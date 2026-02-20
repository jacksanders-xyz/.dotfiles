local part = require("jacksvimlua.daypart") -- "morning" | "mid-day" | "night"
return {
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		lazy = false,
		priority = 1000,
		config = function()
			if part == "morning" then
				require("nightfox").setup({
					options = { transparent = true },
					palettes = {
						dayfox = {
							bg1 = "#ced1d4",
							bg2 = "#b9bcc0",
							bg0 = "#9ea3a9",
							sel0 = "#a9a49e",
						},
					},
				})
				vim.cmd.colorscheme("dayfox")

				-- -- sel0 = "#2a2a38",
				vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#6b7280", bg = "NONE" })
				local function fix_telescope_borders()
					local hl = vim.api.nvim_set_hl
					local p = require("nightfox.palette").load("dayfox")
					local mellow = "#9ea3a9" -- main bar / column
					local mellow_nc = "#b6bbc2" -- inactive

					-- bg3 the yellow one
					vim.api.nvim_set_hl(0, "ColorColumn", { bg = mellow, blend = 12 })
					vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = p.fg1, bg = "NONE" })

					vim.api.nvim_set_hl(0, "StatusLine", { bg = mellow, blend = 8 })
					vim.api.nvim_set_hl(0, "StatusLineNC", { bg = mellow_nc, blend = 8 })

					vim.api.nvim_set_hl(0, "LineNr", { fg = "#8f8fab" })

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
					}) do
						hl(0, g, { fg = p.fg1, bg = "NONE" })
					end
				end

				fix_telescope_borders()
				vim.api.nvim_create_autocmd("ColorScheme", {
					pattern = "dayfox",
					callback = fix_telescope_borders,
				})
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			if part ~= "morning" then
				local flavour = (part == "mid-day") and "frappe" or "mocha"
				require("catppuccin").setup({
					flavour = flavour, -- (midday) or mocha (night)
					transparent_background = false,
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

				-- shared
				local hl = vim.api.nvim_set_hl
				local c = require("catppuccin.palettes").get_palette()

				vim.cmd.colorscheme("catppuccin")
				vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.surface2, bg = "NONE" })

				if part == "night" then
					-- hl(0, "NoiceCmdlinePopup", { fg = c.surface2, bg = "#080c10" }) -- night
					hl(0, "NoiceCmdlinePopup", { fg = c.surface2, bg = "none" }) -- night
					hl(0, "LightBulbDimmer", { fg = c.surface2 }) -- night
					-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- Set background for LSP floats
					-- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8be9fd", bg = "none" }) -- black boxes if you want
				end

				if part == "mid-day" then
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" }) -- Set background for LSP floats
					vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8be9fd", bg = "none" })
				end
			end
		end,
	},
}
