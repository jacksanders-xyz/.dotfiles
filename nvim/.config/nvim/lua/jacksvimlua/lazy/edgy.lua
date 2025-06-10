local function traverser_focus(modes)
	-- print(modes)
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local t = vim.w[win].trouble
		if t and t.type == "split" and t.relative == "editor" then
			for _, candidate in ipairs(modes) do
				if t.mode == candidate then
					vim.api.nvim_set_current_win(win)
					return win
				end
			end
		end
	end

	vim.notify("No matching Traverser window found", vim.log.levels.WARN)
	return nil
end
-- ① Helper: “press” a key sequence as if typed, allowing mappings (recursive)
local function feedkey_mapped(keystr)
	-- Convert “<C-Right>” into the internal termcode representation
	local term = vim.api.nvim_replace_termcodes(keystr, true, false, true)
	-- Feed it with ‘m’ so that remappable mappings (e.g. Edgy’s <C-Right>) trigger
	vim.api.nvim_feedkeys(term, "m", false)
end

-- ② Focus+toggle helper: find the window, focus it, then send <C-Right> or <C-Left>
local current_maxed_win = nil

Mode_lookup = {
	s = { "symbols", "traverser_symbols" },
	i = { "lsp_incoming_calls", "traverser_incoming" },
	o = { "lsp_outgoing_calls", "traverser_outgoing" },
	d = { "diagnostics", "traverser_diagnostics" },
	lr = { "lsp", "traverser_lsp" },
}

local function window_jump(mode_key)
	local modes = Mode_lookup[mode_key]
	if not modes then
		vim.notify("no mode open" .. tostring(mode_key), vim.log.levels.ERROR)
		return
	end

	-- 1) Focus the requested window
	local win = traverser_focus(modes)
	if not win then
		return
	end
end

local function toggle_trav_max(mode_key)
	local modes = Mode_lookup[mode_key]
	if not modes then
		vim.notify("Invalid key for toggle_trav_max: " .. tostring(mode_key), vim.log.levels.ERROR)
		return
	end

	-- 1) Focus the requested window
	local win = traverser_focus(modes)
	if not win then
		return
	end

	-- 2) Determine this window’s “position” (bottom, left, right, or top)
	local t = vim.w[win].trouble
	local pos = t and t.position or "left"

	-- Choose grow/shrink keys based on `pos`
	local grow_key, shrink_key
	if pos == "bottom" then
		grow_key = "<leader>TRU" -- grow vertically upward
		shrink_key = "<leader>TRD" -- shrink vertically downward
	else
		-- covers “left”, “right”, or “top”
		grow_key = "<leader>TRR" -- grow horizontally
		shrink_key = "<leader>TRL" -- shrink horizontally
	end

	-- 3) If this same window is already maxed, schedule shrink + return cursor
	if current_maxed_win == win and vim.api.nvim_win_is_valid(win) then
		vim.schedule(function()
			feedkey_mapped(shrink_key)
			-- vim.cmd("wincmd p")
			current_maxed_win = nil
		end)
		return
	end

	-- 4) If some other window was currently maxed, restore it first
	if current_maxed_win and vim.api.nvim_win_is_valid(current_maxed_win) then
		vim.api.nvim_set_current_win(current_maxed_win)
		vim.schedule(function()
			local prev_t = vim.w[current_maxed_win].trouble
			local prev_pos = (prev_t and prev_t.position) or "left"
			if prev_pos == "bottom" then
				feedkey_mapped("<leader>TRD")
			else
				feedkey_mapped("<leader>TRL")
			end
		end)
	end

	-- 5) Focus the newly requested window again, then schedule grow
	vim.api.nvim_set_current_win(win)
	vim.schedule(function()
		feedkey_mapped(grow_key)
		current_maxed_win = win
	end)
end

return {
	-- edgy
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>ue", -- kill all edgy stuff
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
			-- throw a picker that lets you select the windws
			-- maybe
			{
				"<leader>uE",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
			------------
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>ts",
				function()
					window_jump("s")
				end,
				desc = "Jump to Symbols",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>td",
				function()
					window_jump("d")
				end,
				desc = "Jump to Diagnostics",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>tr",
				function()
					window_jump("lr")
				end,
				desc = "Jump to References",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>ti",
				function()
					window_jump("i")
				end,
				desc = "Jump to Incoming Calls",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>to",
				function()
					window_jump("o")
				end,
				desc = "Jump to outgoing calls",
			},
			------------
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>t,s",
				function()
					toggle_trav_max("s")
				end,
				desc = "Toggle + Maximise Traverser-Symbols pane",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>t,d",
				function()
					toggle_trav_max("d")
				end,
				desc = "Toggle + Maximise diagnostics pane",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>t,r",
				function()
					toggle_trav_max("lr")
				end,
				desc = "Toggle + Maximise diagnostics pane",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>t,i",
				function()
					toggle_trav_max("i")
				end,
				desc = "Toggle + Maximise incoming calls pane",
			},
			{
				-- “t,s” toggles + maxes exactly one window at a time:
				"<leader>t,o",
				function()
					toggle_trav_max("o")
				end,
				desc = "Toggle + Maximise outgoing calls pane",
			},
		},
		opts = function()
			local opts = {
				bottom = {
					"Trouble", --m maybe you can name them in here for picker but meh?
				},
				left = {},
				right = {},

				-- maximizer keys might have to go in here...
				keys = {
					-- increase width
					["<leader>TRR"] = function(win)
						win:resize("width", 76)
					end,
					-- decrease width
					["<leader>TRL"] = function(win)
						win:resize("width", -76)
					end,
					-- increase height
					["<leader>TRU"] = function(win)
						win:resize("height", 10)
					end,
					-- decrease height
					["<leader>TRD"] = function(win)
						win:resize("height", -10)
					end,
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					["<c-Down>"] = function(win)
						win:resize("height", -2)
					end,
				},
				animate = {
					enabled = false,
				},
			}

			-- trouble
			-- this thing is gonna let you give the window information of the trouble windows to edgy i think

			-- opts is the table above table... you are looping through top bot left etc.
			for _, pos in ipairs({ "top", "bottom", "left", "right" }) do -- loop through with a 1: top 2:bottom 3:left 4: right
				opts[pos] = opts[pos] or {} -- pos is your iterator, position. its top bottom left or right

				table.insert(opts[pos], { -- insert into the table that table
					ft = "trouble", -- filetype is trouble
					title = "Traverser",
					filter = function(_buf, win)
						local t = vim.w[win].trouble -- may be nil for non-Trouble / preview windows
						if not t or vim.w[win].trouble_preview then
							return false -- let Edgy ignore this window
						end

						-- everything below is now safe
						local mode_ok = t.mode == "traverser_lsp"
							or t.mode == "traverser_symbols"
							or t.mode == "traverser_incoming"
							or t.mode == "traverser_outgoing"
							or t.mode == "traverser_diagnostics"

						return mode_ok and t.position == pos and t.type == "split" and t.relative == "editor"
					end,
				})
				-- OLD BUT HERE TO EXPLAIN:
				-- filter = function(_buf, win) -- give it a filter (edgy filter filters buffers and windows)
				--     local mode_ok = vim.w[win].trouble.mode == "traverser_lsp" -- look for these only
				--     or vim.w[win].trouble.mode == "traverser_symbols"
				--     or vim.w[win].trouble.mode == "traverser_incoming"
				--     or vim.w[win].trouble.mode == "traverser_outgoing"
				--     or vim.w[win].trouble.mode == "traverser_diagnostics"
				--
				--     -- cause normally you filter add filters to the entries in opts, so it knows which
				--     -- windows to manipulate
				--     return vim.w[win].trouble -- the definiton of the match. run :echo w:trouble or lua print(vim.wo.trouble) it outputs:
				--         -- {'mode': 'lsp', 'type': 'split', 'relative': 'editor', 'position': 'bottom'}
				--         -- it will show you the window var table. here you can select or filter
				--         -- you can make your own custom mode that is basically a lsp. then filter for it. thats how it will only grab
				--         -- the traverser, they will be custom modes in the trouble setup func opts
				--         and mode_ok
				--         and vim.w[win].trouble.position == pos -- you seT THESE POSITIONS IN trouble.lua so they are grabbed
				--         -- and put in here.
				--         -- these are calls to the trouble api
				--         and vim.w[win].trouble.type == "split"
				--         and vim.w[win].trouble.relative == "editor"
				--         and not vim.w[win].trouble_preview
				--     -- when all these conditions are matched the filter puts the window into edgy config
				-- end,

				table.insert(opts[pos], { -- if a normal
					ft = "trouble",
					title = "Trouble",
					filter = function(_buf, win)
						local t = vim.w[win].trouble
						if not t or vim.w[win].trouble_preview then
							return false
						end

						local mode_ok = t.mode == "lsp"
							or t.mode == "symbols"
							or t.mode == "lsp_references"
							or t.mode == "lsp_incoming_calls"
							or t.mode == "lsp_outgoing_calls"
							or t.mode == "diagnostics"

						return mode_ok and t.position == pos and t.type == "split" and t.relative == "editor"
					end,
				})
			end

			-- this LINKS your trouble setup to this edgy config
			return opts
		end,
	},
}
