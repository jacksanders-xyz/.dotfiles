return {
	{
		"folke/trouble.nvim",
		config = function()
			local drawer_size = 56
			-- local drawer_size = 32

			local gp_state = { ns = nil, buf = nil, prev_hl = nil, word = nil }
			---------------------------------------------------------------------------
			--  ONE shared gp action (place this ABOVE `require("trouble").setup`)
			---------------------------------------------------------------------------
			local function gp_action()
				---------------------------------------------------------------- word
				local word = vim.fn.expand("<cword>")
				if word == "" then
					vim.api.nvim_echo({ { "gp: no word under cursor", "WarningMsg" } }, false, {})
					return
				end

				---------------------------------------------------------------- pick real-editor win/buf
				local main_win, main_buf, best = nil, nil, -1
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
					local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
					if ft ~= "Trouble" and bt == "" then
						local a = vim.api.nvim_win_get_width(win) * vim.api.nvim_win_get_height(win)
						if a > best then
							main_win, main_buf, best = win, buf, a
						end
					end
				end
				if not main_buf then
					vim.api.nvim_echo({ { "gp: no editor window found", "WarningMsg" } }, false, {})
					return
				end

				---------------------------------------------------------------- toggle store
				local st = vim.g.__gp_state or {}
				if st.buf == main_buf and st.word == word and st.ns then
					vim.api.nvim_buf_clear_namespace(st.buf, st.ns, 0, -1)
					if st.prev_hl ~= nil then
						vim.o.hlsearch = st.prev_hl
					end
					vim.g.__gp_state = nil
					vim.api.nvim_echo({ { "gp: highlight cleared", "MoreMsg" } }, false, {})
					return
				end
				if st.ns and vim.api.nvim_buf_is_valid(st.buf or -1) then
					vim.api.nvim_buf_clear_namespace(st.buf, st.ns, 0, -1)
				end

				---------------------------------------------------------------- set new highlight
				local ns = vim.api.nvim_create_namespace("TroubleGp")
				local patt = "\\<" .. vim.fn.escape(word, "\\") .. "\\>"
				local prev_hl = vim.o.hlsearch
				vim.fn.setreg("/", patt)
				vim.o.hlsearch, vim.o.incsearch = true, true

				local lines = vim.api.nvim_buf_get_lines(main_buf, 0, -1, false)
				for l, line in ipairs(lines) do
					for s in line:gmatch("()(%f[%w_])" .. vim.pesc(word) .. "%f[%W]") do
						vim.api.nvim_buf_add_highlight(main_buf, ns, "IncSearch", l - 1, s - 1, s - 1 + #word)
					end
				end

				-- center first match without moving focus out of Trouble
				vim.api.nvim_win_call(main_win, function()
					vim.fn.search(patt, "cw")
					-- vim.cmd("normal! zz")
				end)

				vim.g.__gp_state = { ns = ns, buf = main_buf, word = word, prev_hl = prev_hl }
				vim.cmd("redraw")
			end

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
      vim.api.nvim_echo({ { "Library filter OFF", "MoreMsg" } }, false, {})
    else
      -- turn ON: keep only non-library items
      view:filter(function(item) return not is_library(item) end, {
        id       = "libtoggle",
        template = "{hl:Title}Filter:{hl} hide-libs",
      })
      vim.w.lib_filter_on = true
      vim.api.nvim_echo({ { "Library filter ON", "MoreMsg" } }, false, {})
    end

    require("trouble").refresh({ mode = view.mode })  -- redraw list
  end,
},

					-- toggle highlight
					["gp"] = { desc = "Toggle persistent /<cword> highlight", action = gp_action },

					-- next Trouble item then highlight it
					["}"] = {
						desc = "Next item → gp",
						action = function()
							require("trouble").next({ skip_groups = true, jump = false })
							vim.schedule(gp_action)
						end,
					},

					-- previous Trouble item then highlight it
					["{"] = {
						desc = "Prev item → gp",
						action = function()
							require("trouble").prev({ skip_groups = true, jump = false })
							vim.schedule(gp_action)
						end,
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
						sort = { "pos" },
						preview = {
							type = "main",
							highlight = {
								groups = { caller = "Search", callee = "IncSearch" }, -- use any hl-groups you like
							},
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

			local trouble = require("trouble")
			-- ---------------------------------------------------------------------------
			--  Helper funcs
			-- ---------------------------------------------------------------------------

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
				trouble.toggle("diagnostics")
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
