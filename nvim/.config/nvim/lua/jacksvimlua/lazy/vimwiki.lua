local part = require("jacksvimlua.daypart")
local colors -- declare in the outer scope so we can fill it later

if part == "morning" then
	colors = require("nightfox.palette").load("dayfox")
elseif part == "mid-day" then
	colors = require("catppuccin.palettes").get_palette("frappe")
elseif part == "night" then
	colors = require("catppuccin.palettes").get_palette("mocha")
end
return {
	{
		"vimwiki/vimwiki",
		config = function()
			vim.g.vimwiki_table_mappings = 0
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.taskwiki_markup_syntax = "markdown"
			vim.g.markdown_folding = 1

			vim.g.vimwiki_ext2syntax = {
				[".md"] = "markdown",
				[".markdown"] = "markdown",
				[".mdown"] = "markdown",
			}

			vim.g.vimwiki_list = {
				{ path = "~/VimWiki", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/RedHat", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/RedHat/DO180", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/PIPELINE", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/CLUSTER", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/AIandML", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/LANGS", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/WORKFLOW", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain/RANDOM", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/work_content", syntax = "markdown", ext = ".md" },
			}

			local current_colorscheme = vim.g.colors_name
			if current_colorscheme == "dayfox" then
				-- Header highlights using Catppuccin colors
				vim.api.nvim_set_hl(0, "VimwikiHeader2", { fg = colors.green.base })
				vim.api.nvim_set_hl(0, "VimwikiHeader3", { fg = colors.red.base })
				vim.api.nvim_set_hl(0, "VimwikiHeader4", { fg = colors.blue.base })
				vim.api.nvim_set_hl(0, "VimwikiHeader5", { fg = colors.yellow.base })
			else
				-- catppuccin
				vim.api.nvim_set_hl(0, "VimwikiHeader2", { fg = colors.peach })
				vim.api.nvim_set_hl(0, "VimwikiHeader3", { fg = colors.red })
				vim.api.nvim_set_hl(0, "VimwikiHeader4", { fg = colors.blue })
				vim.api.nvim_set_hl(0, "VimwikiHeader5", { fg = colors.yellow })
			end
		end,
	},
}
