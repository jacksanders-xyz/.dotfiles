local function traverser_picker(modes)
	local wanted = {}
	if type(modes) == "table" then
		for _, m in ipairs(modes) do
			wanted[m] = true
		end
	else
		wanted[modes] = true
	end

	return function()
		require("edgy").select(function(_, win)
			local t = vim.w[win].trouble
			return t and t.type == "split" and t.relative == "editor" and wanted[t.mode]
		end)
	end
end

local function traverser_focus(modes)
	local wanted = {}
	if type(modes) == "table" then
		for _, m in ipairs(modes) do
			wanted[m] = true
		end
	else
		wanted[modes] = true
	end

	return function()
		local edgy = require("edgy")
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			local t = vim.w[win].trouble
			if t and t.type == "split" and t.relative == "editor" and wanted[t.mode] then
				vim.api.nvim_set_current_win(win)
				return
			end
		end
		vim.notify("No matching Traverser window found", vim.log.levels.WARN)
	end
end

-- maximizer
local sym_trav_max = false
local function toggle_traverser_symbols()
	sym_trav_max = not sym_trav_max

	-- The exact same arguments you used in toggle_symbols(), but with mode="traverser_symbols"
	require("trouble").toggle({
		mode = "traverser_symbols",
		focus = true,
		win = {
			position = "left",
			size = sym_trav_max and math.floor(vim.o.columns * 0.7) -- 70% when maximised
				or 40, -- fallback to your “normal” width
			winfixwidth = false,
		},
	})
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
			{
				"<leader>ts",
				traverser_focus("traverser_symbols"), -- jump directly to it
				desc = "Traverser Focus: Symbols",
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
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
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
					filter = function(_buf, win) -- give it a filter (edgy filter filters buffers and windows)
						local mode_ok = vim.w[win].trouble.mode == "traverser_lsp" -- look for these only
							or vim.w[win].trouble.mode == "traverser_symbols"
							or vim.w[win].trouble.mode == "traverser_incoming"
							or vim.w[win].trouble.mode == "traverser_outgoing"

						-- cause normally you filter add filters to the entries in opts, so it knows which
						-- windows to manipulate
						return vim.w[win].trouble -- the definiton of the match. run :echo w:trouble or lua print(vim.wo.trouble) it outputs:
							-- {'mode': 'lsp', 'type': 'split', 'relative': 'editor', 'position': 'bottom'}
							-- it will show you the window var table. here you can select or filter
							-- you can make your own custom mode that is basically a lsp. then filter for it. thats how it will only grab
							-- the traverser, they will be custom modes in the trouble setup func opts
							and mode_ok
							and vim.w[win].trouble.position == pos -- you seT THESE POSITIONS IN trouble.lua so they are grabbed
							-- and put in here.
							-- these are calls to the trouble api
							and vim.w[win].trouble.type == "split"
							and vim.w[win].trouble.relative == "editor"
							and not vim.w[win].trouble_preview
						-- when all these conditions are matched the filter puts the window into edgy config
					end,
				})
			end
			-- this LINKS your trouble setup to this edgy config
			return opts
		end,
	},
}
