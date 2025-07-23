return {
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = { transparent = true },
				palettes = {
					dayfox = {
						-- Normal = "#9ea3a9",
						-- NormalNC = "#9ea3a9",
						-- NormalFloat = "#9ea3a9",
						-- MsgArea = "#9ea3a9",
						-- LineNr = "#9ea3a9",
						-- CursorLineNr = "#9ea3a9",
						-- StatusLine = "#9ea3a9",
						-- StatusLineNC = "#9ea3a9",
						-- EdgyNormal = "#9ea3a9",
						-- EdgyNormalNC = "#9ea3a9",
						-- TroubleNormal = "#9ea3a9",
						-- TroubleNormalNC = "#9ea3a9",
						bg1 = "#ced1d4",
						bg2 = "#b9bcc0",
						sel0 = "#2a2a38",
					},
				},
			})
			-- uncomment for day theme--
			vim.cmd.colorscheme("dayfox")
			-----------------------------
			vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
			local function fix_telescope_borders()
				local hl = vim.api.nvim_set_hl
				local p = require("nightfox.palette").load("dayfox")

				local mellow = "#9ea3a9" -- main bar / column
				local mellow_nc = "#b6bbc2" -- inactive

				-- bg2 -- meh
				-- bg1 --nope

				-- bg3 the yellow one
				vim.api.nvim_set_hl(0, "ColorColumn", { bg = mellow, blend = 12 })
				vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = p.fg1, bg = "NONE" })
				-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = mellow, blend = 12 })
				vim.api.nvim_set_hl(0, "StatusLine", { bg = mellow, blend = 8 })
				vim.api.nvim_set_hl(0, "StatusLineNC", { bg = mellow_nc, blend = 8 })

				local border = (p.fg1 and p.black.base) or p.black or p.bg3 or "#333333"
				-- Border + titles
				for _, part in ipairs({ "Prompt", "Results", "Preview" }) do
					hl(0, "Telescope" .. part .. "Border", { fg = border, bg = "NONE" })
					hl(0, "Telescope" .. part .. "Title", { fg = border, bold = true })
				end
				hl(0, "TelescopeBorder", { fg = border, bg = "NONE" })
				hl(0, "FloatBorder", { fg = border, bg = "NONE" })
				for _, g in ipairs({
					"TelescopeResultsNormal",
					"TelescopeResultsTitle",
					"TelescopeResultsNumber",
					"TelescopeResultsLine",
					"TelescopeNormal",
					"Number",
					"NonText",
					"LineNr",
				}) do
					hl(0, g, { fg = p.fg1, bg = "NONE" })
				end
			end
			fix_telescope_borders()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "dayfox",
				callback = fix_telescope_borders,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				show_end_of_buffer = true,
				styles = {
					comments = { "italic" },
					keywords = { "italic" },
					functions = {},
					statements = { "bold" },
					types = {},
				},
				integrations = {
					telescope = true,
					nvimtree = true,
					which_key = true,
				},
				color_overrides = {
					mocha = {
						base = "#080c10",
					},
				},
			})

			-- uncomment for light theme
			-- local hl = vim.api.nvim_set_hl
			-- local c = require("catppuccin.palettes").get_palette()
			-- hl(0, "NoiceCmdlinePopup", { fg = c.surface2, bg = "#080c10" })
			-- hl(0, "LightBulbDimmer", { fg = c.surface2 })
			-- vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
			-- vim.cmd.colorscheme("catppuccin")
			-----------------------------------------------------------------
		end,
	},
}
