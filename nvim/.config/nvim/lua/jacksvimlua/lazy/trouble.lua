return {
	{
		"folke/trouble.nvim",
		config = function()
			------- no stupid alert
			local orig_notify = vim.notify
			vim.notify = function(msg, level, opts)
				if type(msg) == "string" and msg:match("vim%.validate is deprecated") then
					return
				end
				orig_notify(msg, level, opts)
			end
			------- no stupid alert

			local drawer_size = 56
			local last_out_item = nil

			local function is_library(item)
				local f = item.filename or ""
				return f:match("^/usr") -- std-lib
					or f:match("/pkg/mod/") -- Go module cache
					or f:match("/vendor/") -- vendored deps
					or f:match("node_modules") -- JS/TS deps
			end

			require("trouble").setup({
				keys = {
					-- 1. Unmap `s` so Flash/Hop can use it
					s = false,
					-- 2. Re-add the same “toggle severity filter” logic on `S`
					S = {
						action = function(view)
							-- identical to the default `s` action
							local f = view:get_filter("severity")
							local severity = ((f and f.filter.severity or 0) + 1) % 5
							view:filter({ severity = severity }, {
								id = "severity",
								template = "{hl:Title}Filter:{hl} {severity}",
								del = severity == 0,
							})
						end,
						desc = "Toggle Severity Filter",
					},
					["L"] = {
						desc = "Toggle library filter (Outgoing pane)",
						action = function(view)
							-- works in raw 'lsp_outgoing_calls' or traverser alias
							local wm = vim.w.trouble and vim.w.trouble.mode
							if wm ~= "traverser_outgoing" and view.mode ~= "lsp_outgoing_calls" then
								vim.api.nvim_echo({ { "L only in Outgoing pane", "WarningMsg" } }, false, {})
								return
							end

							if vim.w.lib_filter_on then
								-- turn OFF
								view:filter(nil, { id = "libtoggle", del = true })
								vim.w.lib_filter_on = false
							else
								-- turn ON: keep only non-library items
								view:filter(function(item)
									return not is_library(item)
								end, {
									id = "libtoggle",
									template = "{hl:Title}Filter:{hl} hide-libs",
								})
								vim.w.lib_filter_on = true
							end

							require("trouble").refresh({ mode = view.mode })
						end,
					},
					["<c-r>"] = { -- call on an outgoing func to see scoped references
						-- populates quickfix list, use <leader>tq for trouble view, :cnext/:cprev to navigate
						desc = "Scoped refs: quickfix list of references within the caller's function",
						action = function(view)
							local loc = view:at()
							local item = loc.item
							if not item then
								vim.notify("No item under cursor", vim.log.levels.WARN)
								return
							end

							local def_file = item.filename
							local def_line = item.pos and item.pos[1] or nil

							-- Get caller's file + function scope from the code window
							local caller_file, start_l, end_l, code_win
							for _, win in ipairs(vim.api.nvim_list_wins()) do
								local bufnr = vim.api.nvim_win_get_buf(win)
								local cfg = vim.api.nvim_win_get_config(win)
								local t = vim.w[win].trouble
								local bt = vim.bo[bufnr].buftype
								local ft = vim.bo[bufnr].filetype

								if not t and cfg.relative == "" and bt == "" and ft ~= "trouble" then
									code_win = win
									caller_file = vim.api.nvim_buf_get_name(bufnr)

									local result = vim.api.nvim_win_call(win, function()
										local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr)
										if ok_parser and parser then
											parser:parse()
										end
										local ts_node = vim.treesitter.get_node()
										if not ts_node then
											return nil
										end
										local func_types = {
											"function_definition",
											"function_declaration",
											"method_declaration",
											"func_literal",
											"function",
											"method",
										}
										while ts_node and not vim.tbl_contains(func_types, ts_node:type()) do
											ts_node = ts_node:parent()
										end
										if not ts_node then
											return nil
										end
										local sr, _, er, _ = ts_node:range()
										return { sr + 1, er + 1 }
									end)
									if result then
										start_l = result[1]
										end_l = result[2]
									end
									break
								end
							end

							if not start_l then
								vim.notify("Couldn't detect function scope (Treesitter). Navigate to the caller's file first.", vim.log.levels.WARN)
								return
							end

							view:jump()

							vim.schedule(function()
								local clients = vim.lsp.get_clients({ bufnr = 0 })
								local encoding = clients[1] and clients[1].offset_encoding or "utf-16"
								local params = vim.lsp.util.make_position_params(0, encoding)
								params.context = { includeDeclaration = false }

								vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
									if err or not result or #result == 0 then
										vim.notify("No references found", vim.log.levels.INFO)
										return
									end

									local qf_items = {}
									for _, ref in ipairs(result) do
										local ref_file = vim.uri_to_fname(ref.uri)
										local ref_line = ref.range.start.line + 1
										local ref_col = ref.range.start.character + 1

										local is_definition = def_line
											and vim.fn.fnamemodify(ref_file, ":p") == vim.fn.fnamemodify(def_file, ":p")
											and ref_line == def_line

										if not is_definition then
											local same_file = vim.fn.fnamemodify(ref_file, ":p")
												== vim.fn.fnamemodify(caller_file, ":p")
											local in_scope = ref_line >= start_l and ref_line <= end_l

											if same_file and in_scope then
												local bufnr = vim.fn.bufadd(ref_file)
												vim.fn.bufload(bufnr)
												local lines = vim.api.nvim_buf_get_lines(bufnr, ref_line - 1, ref_line, false)
												local text = lines[1] and vim.trim(lines[1]) or ""

												table.insert(qf_items, {
													filename = ref_file,
													lnum = ref_line,
													col = ref_col,
													text = text,
												})
											end
										end
									end

									if #qf_items == 0 then
										vim.notify("No references in current function scope", vim.log.levels.INFO)
										return
									end

									if #qf_items == 1 then
										if code_win and vim.api.nvim_win_is_valid(code_win) then
											vim.api.nvim_set_current_win(code_win)
										end
										local qf = qf_items[1]
										local bufnr = vim.fn.bufadd(qf.filename)
										vim.fn.bufload(bufnr)
										vim.api.nvim_win_set_buf(0, bufnr)
										vim.api.nvim_win_set_cursor(0, { qf.lnum, qf.col - 1 })
										vim.cmd("normal! zz")
										return
									end

									vim.fn.setqflist(qf_items, "r")
									vim.fn.setqflist({}, "a", { title = "Scoped refs (in caller)" })

									if code_win and vim.api.nvim_win_is_valid(code_win) then
										vim.api.nvim_set_current_win(code_win)
									end
									vim.cmd("cfirst")
								end)
							end)
						end,
					},
				},
				modes = {
					traverser_lsp = {
						sections = {
							"lsp_declarations",
							"lsp_implementations", -- where the interface is being implemented
							"lsp_references", -- where the thing is reference
							"lsp_type_definitions",
						},
						title = "󰌹  Refs / Defs",
						follow = true,
						auto_refresh = true,
						params = { include_declaration = false },
						pinned = false,
						preview = {
							type = "main",
						},
						include_current = true,
						open_no_results = true,
						lsp_base = {
							params = {
								-- don't include the current location in the results
								include_current = true,
							},
						},
						win = {
							type = "split",
							position = "bottom",
							size = 80,
						},
					},
					traverser_symbols = {
						mode = "symbols",
						title = "󰳽  Symbols",
						follow = true,
						open_no_results = true,
						win = { type = "split", position = "left", size = drawer_size },
					},
					traverser_diagnostics = {
						mode = "diagnostics",
						title = "  Diagnostics",
						open_no_results = true,
						follow = true,
						win = {
							type = "split",
							position = "left",
							height = 6,
						},
					},
					traverser_incoming = {
						mode = "lsp_incoming_calls",
						title = "  Incoming",
						open_no_results = true,
						follow = true,
						win = { type = "split", position = "right", height = 6 },
					},
					traverser_outgoing = {
						mode = "lsp_outgoing_calls",
						title = "  Outgoing",
						open_no_results = true,
						auto_preview = false,
						follow = true,
						-- groups = false,
						sort = { "pos" },
						preview = {
							type = "main",
						},

						win = { type = "split", position = "right", height = 6 },
					},
					traverser_tree = {
						mode = "quickfix", -- leverage QF engine
						title = "󰈞  Trace",
						groups = false, -- flat tree, toggle to group by file
						sort = { "text" }, -- sort by “[tag] …”
						follow = true,
						win = { type = "split", position = "bottom", height = 8 },
					},
				},
			})

			-- ---------------------------------------------------------------------------
			--  Helper funcs
			-- ---------------------------------------------------------------------------
			local trouble = require("trouble")
			local last_trouble_mode = nil -- e.g. "traverser_lsp", "traverser_symbols", …

			-- Whenever we enter a window, check if it’s a Trouble window and remember it
			vim.api.nvim_create_autocmd("WinEnter", {
				desc = "Remember the last Trouble view we stepped into",
				callback = function()
					-- In the window we just entered, Trouble (if present) leaves its metadata
					local t = vim.w.trouble -- NO indexing by ID – vim.w is per-window
					if t and t.mode then
						last_trouble_mode = t.mode
					end
				end,
			})

			-- Helper that falls back gracefully if no Trouble view is open
			local function jump(dir) -- dir = "next" | "prev"
				local opts = { skip_groups = true, jump = true }

				-- if we still have a live Trouble window with that mode, target it explicitly
				if last_trouble_mode and trouble.is_open(last_trouble_mode) then
					opts.mode = last_trouble_mode -- tell Trouble which view to use
				end

				trouble[dir](opts) -- call .next() or .prev()
			end

			-- --------------------------------------------------------------------------
			-- -- "DIAGNOSTICS"
			-- --------------------------------------------------------------------------
			-- -- this will throw trouble toggle diagnostics for the whole workspace
			-- -- (because your lsp has the plugin "artemave/workspace-diagnostics.nvim"
			vim.keymap.set("n", "<leader>tt", function()
				trouble.toggle({
					mode = "diagnostics",
					win = {
						wo = { wrap = true },
					},
				})
			end)

			-- this will throw trouble toggle diagnostics ONLY for buffer you're in
			vim.keymap.set("n", "<leader>tb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")

			--------------------------------------------------------------------------
			-- "SYMBOLS" - a tree of symbols
			--------------------------------------------------------------------------
			vim.keymap.set("n", "<leader>TS", function()
				trouble.toggle({
					mode = "symbols",
					focus = false,
					win = {
						position = "left",
						size = drawer_size,
					},
				})
			end, { desc = "Symbols (Trouble) left" })

			--------------------------------------------------------------------------
			-- "LSP DEFINITIONS/REFERENCES"
			--------------------------------------------------------------------------
			-- on the cursor it will show everywhere something is REFERENCED or DEFINED
			vim.keymap.set("n", "<leader>TR", function()
				trouble.toggle({
					mode = "lsp_references",
					focus = false,
					open_no_results = true,
					params = {
						include_declaration = true,
					},
					win = {
						position = "right",
						size = drawer_size,
					},
				})
			end, { desc = "LSP DEFINITIONS/REFERENCES (Trouble)" })

			--------------------------------------------------------------------------
			-- "CALL HIERARCHY"
			--------------------------------------------------------------------------
			-- WHO CALLS THIS FUNCTION? / WHO CALLS "INTO" THIS? => "ci"
			vim.keymap.set("n", "<leader>TI", function()
				trouble.toggle({
					mode = "lsp_incoming_calls",
					open_no_results = true,
					win = {
						position = "right",
						size = drawer_size,
					},
				})
			end, { desc = "Incoming calls (Trouble)" })

			-- WHAT FUNCTIONS DOES THIS CALL OUT TOO?
			vim.keymap.set("n", "<leader>TO", function()
				trouble.toggle({
					mode = "lsp_outgoing_calls",
					open_no_results = true,
					win = {
						position = "right",
						size = drawer_size,
					},
				})
			end, { desc = "Outgoing calls (Trouble)" })

			--------------------------------------------------------------------------
			-- "LISTS" - you need to populate them
			--------------------------------------------------------------------------
			-- whatever is in your quickfix is 'prettified' into a trouble list with tree stuff
			-- TODO add a maximizer for this?
			vim.keymap.set("n", "<leader>tq", function()
				trouble.toggle({
					mode = "quickfix",
					sort = { "pos" },
				})
			end)

			vim.keymap.set("n", "<leader>txt", function() --- IF you open tele results in a trouble window, toggle
				trouble.toggle("telescope")
			end)

			-- you (or something) have to populate your loclist example (:lvimgrep /defer/ % )
			-- the above searches for text 'defer' in current file
			vim.keymap.set("n", "<leader>tl", function()
				trouble.toggle("loclist")
			end)

			--------------------------------------------------------------------------
			-- "NAVIGATING THE TROUBLE WINDOWS"
			--------------------------------------------------------------------------
			vim.keymap.set("n", "<leader>J", function()
				jump("next")
			end, { desc = "Next item in last-used Trouble list" })

			vim.keymap.set("n", "<leader>K", function()
				jump("prev")
			end, { desc = "Prev item in last-used Trouble list" })

			---------------------------------------------------------------------------
			-- Traverser mode – workspace dashboard
			---------------------------------------------------------------------------
			local traverser_active = false
			local traverser_grp = vim.api.nvim_create_augroup("TraverserMode", { clear = true })
			-- local trouble = require("trouble")

			-----------------------------------------------------------------
			-- 0.  Disable the LSP handlers that populate / open quickfix
			-----------------------------------------------------------------
			--  textDocument/references         → use loclist=false  open=false
			vim.lsp.handlers["textDocument/references"] =
				vim.lsp.with(vim.lsp.handlers.locations, { loclist = true, open = false })

			--  callHierarchy/*                 → do nothing (Trouble asks for them)
			vim.lsp.handlers["callHierarchy/incomingCalls"] = function() end
			vim.lsp.handlers["callHierarchy/outgoingCalls"] = function() end

			-------------------------------------------------------
			-- helper: refresh Trouble panes only
			-------------------------------------------------------
			local function refresh_trouble_lists()
				if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then
					return
				end
				trouble.refresh({ mode = "lsp_incoming_calls" })
				trouble.refresh({ mode = "lsp_outgoing_calls" })
				trouble.refresh({ mode = "lsp_references" })
			end

			-------------------------------------------------------
			-- open the dashboard
			-------------------------------------------------------
			local function traverser_open()
				traverser_active = true -- set state for active

				----------------------------------------------------------------
				-- LEFT column ─ Symbols
				----------------------------------------------------------------
				trouble.open({ mode = "traverser_symbols" })
				-- trouble.open({ mode = "traverser_diagnostics" })

				----------------------------------------------------------------
				-- bottom row – Refs / Defs
				----------------------------------------------------------------
				trouble.open({ mode = "traverser_lsp" })

				----------------------------------------------------------------
				-- RIGHT column - call heirarchy
				----------------------------------------------------------------
				trouble.open({ mode = "traverser_incoming" })
				trouble.open({ mode = "traverser_outgoing" })

				-- keep the three call/reference panes fresh
				vim.api.nvim_create_autocmd({ "CursorHold", "BufEnter" }, {
					group = traverser_grp,
					callback = refresh_trouble_lists,
				})
			end

			-------------------------------------------------------
			-- close everything & clean up
			-------------------------------------------------------
			local function traverser_close()
				traverser_active = false
				vim.api.nvim_clear_autocmds({ group = traverser_grp })
				trouble.close({ mode = "traverser_symbols" })
				trouble.close({ mode = "traverser_lsp" })
				trouble.close({ mode = "traverser_incoming" })
				trouble.close({ mode = "traverser_outgoing" })

				pcall(vim.cmd, "lclose") -- also hide any loclist that might be open
			end

			-------------------------------------------------------
			-- public toggle, mapped to <leader>tm
			-------------------------------------------------------
			local function traverser_toggle()
				if traverser_active then
					traverser_close()
				else
					traverser_open()
				end
			end

			vim.keymap.set("n", "<leader>tm", traverser_toggle, { desc = "Toggle Traverser mode" }) --
		end,
	},
}

-- require("trouble").open({ mode = "lsp_references", filter = function(items) return vim.tbl_filter(function(item) local l = item.pos[1] local in_range = l and l >= 250 and l <= 400 return in_range end, items) end, })
