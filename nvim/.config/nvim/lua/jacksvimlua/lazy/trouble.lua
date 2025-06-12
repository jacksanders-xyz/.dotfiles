return {
	{
		"folke/trouble.nvim",
		config = function()
			local drawer_size = 56
			-- local drawer_size = 32

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
				},
				modes = {
					traverser_lsp = {
						sections = {
							"lsp_declarations",
							"lsp_definitions", -- where the thing is defined
							"lsp_implementations", -- where the interface is being implemented
							"lsp_references", -- where the thing is reference
							"lsp_type_definitions",
						},
						title = "󰌹  Refs / Defs",
						follow = true,
						params = { include_declaration = true },
						preview = {
							type = "main",
						},
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
							size = 30,
						},
					},
					traverser_symbols = {
						mode = "symbols",
						title = "󰳽  Symbols",
						follow = true,
						open_no_results = true,
						win = { type = "split", position = "left", size = 56 },
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
						-- win = { type = "split", position = "right", height = 6 },
					},
					traverser_outgoing = {
						mode = "lsp_outgoing_calls",
						title = "  Outgoing",
						open_no_results = true,
						follow = true,
						win = { type = "split", position = "right", height = 6 },
					},
					traverser_tree = {
						mode = "quickfix",
						title = "󰈞  Trace",
						follow = true,
						open_no_results = true,
						win = { type = "split", position = "bottom", height = 8 },
					},
				},
			})

			local trouble = require("trouble")

			--          local diag_max = false
			-- local sym_max = false
			-- local inc_max = false
			-- local out_max = false
			-- local ref_max = false
			-- local function log(msg)
			-- 	vim.notify(msg, vim.log.levels.INFO, { title = "Trouble-toggle" })
			-- 	print("[Trouble-toggle] " .. msg)
			-- end
			-- -- Diagnostics bottom bar
			-- local function toggle_diagnostics()
			-- 	diag_max = not diag_max
			-- 	log("diagnostics → " .. (diag_max and "MAX" or "normal"))
			-- 	trouble.close()
			-- 	trouble.open({
			-- 		mode = "diagnostics",
			-- 		focus = true,
			-- 		win = {
			-- 			position = "bottom",
			-- 			size = diag_max and (vim.o.lines - 4) or 10,
			-- 			winfixheight = false,
			-- 		},
			-- 	})
			-- end
			--
			-- Symbols sidebar
			-- local function toggle_symbols()
			-- 	if sym_max == not sym_max then
			-- 		log("symbols → " .. (sym_max and "MAX" or "normal"))
			-- 		trouble.close()
			-- 		trouble.open({
			-- 			mode = "traverser_symbols",
			-- 			focus = true,
			-- 			win = {
			-- 				position = "left",
			-- 				size = sym_max and math.floor(vim.o.columns * 0.7) or 56,
			-- 				winfixwidth = false,
			-- 			},
			-- 		})
			-- 	else
			-- 		trouble.close()
			-- 		traverser_open()
			-- 	end
			-- end
			-- local function toggle_incoming()
			-- 	inc_max = not inc_max
			-- 	log("incoming calls → " .. (inc_max and "MAX" or "normal"))
			-- 	trouble.close()
			-- 	trouble.open({
			-- 		mode = "lsp_incoming_calls",
			-- 		focus = true,
			-- 		win = {
			-- 			position = "left",
			-- 			size = inc_max and math.floor(vim.o.columns * 0.7) or 40,
			-- 			winfixwidth = false,
			-- 		},
			-- 	})
			-- end
			-- -- local function toggle_outgoing()
			-- -- 	out_max = not out_max
			-- -- 	log("outgoing calls → " .. (out_max and "MAX" or "normal"))
			-- -- 	trouble.close()
			-- -- 	trouble.open({
			-- -- 		mode = "lsp_outgoing_calls",
			-- -- 		focus = true,
			-- -- 		win = {
			-- -- 			position = "right",
			-- -- 			size = out_max and math.floor(vim.o.columns * 0.7) or 40,
			-- -- 			winfixwidth = false,
			-- -- 		},
			-- -- 	})
			-- -- end
			-- -- local function toggle_references()
			-- -- 	ref_max = not ref_max
			-- -- 	log("refs → " .. (ref_max and "MAX" or "normal"))
			-- -- 	trouble.close()
			-- -- 	trouble.open({
			-- -- 		mode = "lsp_references",
			-- -- 		focus = true,
			-- -- 		params = {
			-- -- 			include_declarations = true,
			-- -- 		},
			-- -- 		win = {
			-- -- 			position = "right",
			-- -- 			size = ref_max and math.floor(vim.o.columns * 0.7) or 40,
			-- -- 			winfixwidth = false,
			-- -- 		},
			-- -- 	})
			-- -- end
			-- --
			-- --------------------------------------------------------------------------
			-- -- "DIAGNOSTICS"
			-- --------------------------------------------------------------------------
			-- -- this will throw trouble toggle diagnostics for the whole workspace
			-- -- (because your lsp has the plugin "artemave/workspace-diagnostics.nvim"
			-- vim.keymap.set("n", "<leader>tt", function()
			-- 	trouble.toggle("diagnostics")
			-- end)
			--
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
				trouble.toggle("quickfix")
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
			-- "MAXIMIZING THE WINDOWS"
			--------------------------------------------------------------------------
			-- vim.keymap.set("n", "<leader>t,t", toggle_diagnostics, { desc = "Toggle maximise Trouble diagnostics" })
			-- vim.keymap.set("n", "<leader>t,f", toggle_symbols, { desc = "Toggle maximise Trouble symbols" }) -- change to toggle_sym_max

			-- vim.keymap.set("n", "<leader>t,r", toggle_references, { desc = "Toggle maximise Trouble references" })
			-- vim.keymap.set("n", "<leader>t,i", toggle_incoming, { desc = "Toggle maximise Trouble incoming calls" })
			-- vim.keymap.set("n", "<leader>t,o", toggle_outgoing, { desc = "Toggle maximise Trouble outgoing calls" })

			--------------------------------------------------------------------------
			-- "NAVIGATING THE TROUBLE WINDOWS"
			--------------------------------------------------------------------------
			vim.keymap.set("n", "<leader>J", function()
				trouble.next({ skip_groups = true, jump = true })
			end)
			vim.keymap.set("n", "<leader>K", function()
				trouble.prev({ skip_groups = true, jump = true })
			end)

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

				-- don't know if I need this...
				-- pcall(vim.cmd, "cclose") -- ✱ close any stray quick-fix list

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
