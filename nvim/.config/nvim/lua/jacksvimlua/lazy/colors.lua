-- ~/.config/nvim/lua/plugins/catppuccin.lua
local function ColorMyPencils()
	vim.cmd.colorscheme("catppuccin")
	vim.opt.laststatus = 3
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
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

			-- set your NoiceCmdlinePopup to use the same bg
			-- vim.cmd("highlight! link NoiceCmdlinePopup ColorColumn")

			-- manual highlights for Telescope + Pmenu:
			local hl = vim.api.nvim_set_hl
			local c = require("catppuccin.palettes").get_palette()
			-- hl(0, "NoiceCmdlinePopup", { fg = c.surface2, bg = c.mantle })
			hl(0, "NoiceCmdlinePopup", { fg = c.surface2, bg = "#080c10" })

			-- manual “boxed dark” Telescope highlights
			-- local c = require("catppuccin.palettes").get_palette()
			-- local hl = vim.api.nvim_set_hl
			-- -- Prompt: darkest box
			-- hl(0, "TelescopePromptNormal", { bg = c.crust })
			-- hl(0, "TelescopePromptBorder", { fg = c.crust, bg = c.crust })
			-- -- Results: slightly lighter interior, same dark border
			-- hl(0, "TelescopeResultsNormal", { fg = c.text, bg = c.mantle })
			-- hl(0, "TelescopeResultsBorder", { fg = c.crust, bg = c.crust })
			-- -- Preview: mid‑dark background, matching border
			-- hl(0, "TelescopePreviewNormal", { bg = c.mantle })
			-- hl(0, "TelescopePreviewBorder", { fg = c.base, bg = c.crust })
			-- -- Popup menu: match prompt style
			-- hl(0, "Pmenu", { fg = c.text, bg = c.crust })
			-- hl(0, "PmenuSel", { fg = c.text, bg = c.mantle })
			-- hl(0, "PmenuSbar", { bg = c.mantle })
			-- hl(0, "PmenuThumb", { bg = c.mauve })

			hl(0, "LightBulbDimmer", { fg = c.surface2 })

			ColorMyPencils()
		end,
	},
}
