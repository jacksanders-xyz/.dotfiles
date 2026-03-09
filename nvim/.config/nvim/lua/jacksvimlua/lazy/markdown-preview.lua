local part = require("jacksvimlua.daypart") -- "morning" | "mid-day" | "night"
local theme_key = part:gsub("-", "_") -- "mid-day" -> "mid_day" (lua require safe)

return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		config = function()
			local theme = require("jacksvimlua.render_markdown_themes." .. theme_key)

			-- Apply highlights immediately
			theme.set_highlights()

			-- Re-apply after colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = theme.set_highlights,
			})

			require("render-markdown").setup({
				heading = {
					enabled = true,
					sign = true,
					width = "full",
					icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
					backgrounds = {
						"RenderMarkdownH1Bg",
						"RenderMarkdownH2Bg",
						"RenderMarkdownH3Bg",
						"RenderMarkdownH4Bg",
						"RenderMarkdownH5Bg",
						"RenderMarkdownH6Bg",
					},
					foregrounds = {
						"RenderMarkdownH1",
						"RenderMarkdownH2",
						"RenderMarkdownH3",
						"RenderMarkdownH4",
						"RenderMarkdownH5",
						"RenderMarkdownH6",
					},
				},
				code = {
					enabled = true,
					sign = true,
					style = "full",
					position = "left",
					width = "block",
					left_pad = 2,
					right_pad = 2,
					border = "thin",
				},
				bullet = {
					enabled = true,
					-- Smaller, cleaner list markers (nesting levels 1..4)
					-- icons = { "●", "○", "◆", "◇" },
					icons = { "•", "◦", "▪", "▫" },
				},
				checkbox = {
					enabled = true,
					unchecked = { icon = "󰄱 " },
					checked = { icon = "󰱒 " },
				},
				quote = {
					enabled = true,
					icon = "▎", -- Skinnier vertical bar
					repeat_linebreak = false,
				},
				link = {
					enabled = true,
					custom = {
						web = { pattern = "^http[s]?://", icon = "󰖟 " }, -- Globe icon for external links
						-- path = { pattern = "[/~][-%.%w/_]+", icon = " " }, -- File/folder icon for paths
					},
				},
				callout = {
					note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
					tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
					important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
					warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
					caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
					abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
					todo = { raw = "[!TODO]", rendered = "󰝖 Todo", highlight = "RenderMarkdownInfo" },
					subnote = { raw = "[!SUBNOTE]", rendered = "↳ ", highlight = "RenderMarkdownSubnote" },
				},
			})
		end,
		ft = { "markdown" },
	},
}
