return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			------------------------------------------------------------------
			-- 1.  When should which-key open?
			------------------------------------------------------------------
			--    • Only when you press  z=
			--    • Nothing else is triggered automatically
			triggers = { "z=" },

			------------------------------------------------------------------
			-- 2.  Disable the keys you *don’t* want which-key to watch
			--     (this replaces the deprecated `triggers_blacklist` option)
			------------------------------------------------------------------
			disable = {
				modes = {
					i = { "<C-r>" }, -- Insert mode
					c = { "<C-r>" }, -- Cmd-line (:) mode
				},
			},

			------------------------------------------------------------------
			-- 3.  Built-in helper plugins
			------------------------------------------------------------------
			plugins = {
				marks = false, -- turn off the <m…> helpers
				registers = false, -- turn off the <C-r> popup
				spelling = { enabled = true, suggestions = 40 },

				-- All the preset sub-menus (operators, motions…)
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					g = false,
					z = true, -- keep z-sub-menu for folds & z=
				},
			},

			------------------------------------------------------------------
			-- 4.  Hide the default “marks” and “delete-marks” roots entirely
			--     (otherwise health-check will still *see* them and complain
			--      about overlaps even though the helpers are disabled)
			------------------------------------------------------------------
			defaults = {
				["m"] = nil, -- remove “marks” root
				["dm"] = nil, -- remove “delete-marks” root
			},
		},

		--------------------------------------------------------------------
		-- 5.  Manual shortcut to open which-key on demand
		--------------------------------------------------------------------
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer-local keymaps (which-key)",
			},
		},
	},
}
