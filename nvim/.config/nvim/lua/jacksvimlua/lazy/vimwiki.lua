-- ============================================================================
-- ORIGINAL CONFIG (COMMENTED OUT)
-- To revert: uncomment this section and delete the "NEW CONFIG" section below
-- ============================================================================
--[[
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
		init = function()
			-- CRITICAL: Set this BEFORE VimWiki loads to prevent it from taking over all .md files
			vim.g.vimwiki_global_ext = 0
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
				{ path = "~/VimWiki/work_content", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain", syntax = "markdown", ext = ".md" },
			}
		end,
		config = function()

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
--]]

--
-- vimwiki gets render markdown

return {
	{
		"vimwiki/vimwiki",
		init = function()
			-- Prevent VimWiki from taking over ALL .md files (only files in wiki dirs)
			vim.g.vimwiki_global_ext = 0

			-- Define your wiki directories
			vim.g.vimwiki_list = {
				{ path = "~/VimWiki/work_content", syntax = "markdown", ext = ".md" },
				{ path = "~/VimWiki/jacks_brain", syntax = "markdown", ext = ".md" },
			}

			-- Optional: disable some VimWiki features you might not use
			vim.g.vimwiki_table_mappings = 0
		end,
		config = function()
			-- CRITICAL: Force VimWiki files to use markdown filetype
			-- This allows render-markdown.nvim to work in VimWiki directories
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "vimwiki",
				callback = function()
					vim.bo.filetype = "markdown"
				end,
				desc = "Force VimWiki files to use markdown filetype for render-markdown compatibility",
			})
		end,
	},
}
