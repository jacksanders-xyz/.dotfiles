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
			local function set_markdown_highlights()
				-- Catppuccin Mocha colors for dark theme
				-- Headers: Blue → Green → Red → Violet (increasing intensity)
				vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#1e1e2e", fg = "#89b4fa", bold = true }) -- Blue
				vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#1e1e2e", fg = "#a6e3a1", bold = true }) -- Green
				vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#1e1e2e", fg = "#f38ba8", bold = true }) -- Red
				vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1e1e2e", fg = "#cba6f7", bold = true }) -- Violet
				vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#1e1e2e", fg = "#d5a8f8", bold = true }) -- Brighter Violet
				vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#1e1e2e", fg = "#f5c2e7", bold = true }) -- Intense Magenta

				vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#89b4fa", bold = true }) -- Blue
				vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#a6e3a1", bold = true }) -- Green
				vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#f38ba8", bold = true }) -- Red
				vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#cba6f7", bold = true }) -- Violet
				vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#d5a8f8", bold = true }) -- Brighter Violet
				vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#f5c2e7", bold = true }) -- Intense Magenta

				-- Callout colors
				vim.api.nvim_set_hl(0, "RenderMarkdownInfo", { bg = "#1e1e2e", fg = "#89dceb" })
				vim.api.nvim_set_hl(0, "RenderMarkdownSuccess", { bg = "#1e1e2e", fg = "#a6e3a1" })
				vim.api.nvim_set_hl(0, "RenderMarkdownHint", { bg = "#1e1e2e", fg = "#94e2d5" })
				vim.api.nvim_set_hl(0, "RenderMarkdownWarn", { bg = "#1e1e2e", fg = "#f9e2af" })
				vim.api.nvim_set_hl(0, "RenderMarkdownError", { bg = "#1e1e2e", fg = "#f38ba8" })
				vim.api.nvim_set_hl(0, "RenderMarkdownSubnote", { bg = "#313244", fg = "#a6adc8", italic = true }) -- Subtle box bg

				-- Bullets and list items
				vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#f5c2e7" })

				-- Softer inline code (teal instead of bright green)
				-- vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#94e2d5" })
				vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = "#b4befe" }) -- catppuccin lavender

				-- Tables
				vim.api.nvim_set_hl(0, "RenderMarkdownTableHead", { fg = "#89b4fa", bold = true })
				vim.api.nvim_set_hl(0, "RenderMarkdownTableRow", { fg = "#cdd6f4" })
			end

			-- Apply highlights immediately
			set_markdown_highlights()

			-- Re-apply after colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = set_markdown_highlights,
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
