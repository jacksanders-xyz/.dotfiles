return {
	{
		"vimwiki/vimwiki",
		config = function()
			-- pull Catppuccin palette for header colors
			local colors = require("catppuccin.palettes").get_palette()
			-- local colors = require("midnight.palettes").get_palette()

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

			-- Header highlights using Catppuccin colors
			vim.api.nvim_set_hl(0, "VimwikiHeader2", { fg = colors.peach })
			vim.api.nvim_set_hl(0, "VimwikiHeader3", { fg = colors.red })
			vim.api.nvim_set_hl(0, "VimwikiHeader4", { fg = colors.blue })
			vim.api.nvim_set_hl(0, "VimwikiHeader5", { fg = colors.yellow })
		end,
	},
}
