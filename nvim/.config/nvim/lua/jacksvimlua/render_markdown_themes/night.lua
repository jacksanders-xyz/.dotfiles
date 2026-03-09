-- render-markdown highlights for night (catppuccin mocha, base #080c10)
local M = {}

function M.set_highlights()
	local hl = vim.api.nvim_set_hl

	-- Headers: Blue -> Green -> Red -> Violet (increasing intensity)
	hl(0, "RenderMarkdownH1Bg", { bg = "#1e1e2e", fg = "#89b4fa", bold = true }) -- Blue
	hl(0, "RenderMarkdownH2Bg", { bg = "#1e1e2e", fg = "#a6e3a1", bold = true }) -- Green
	hl(0, "RenderMarkdownH3Bg", { bg = "#1e1e2e", fg = "#f38ba8", bold = true }) -- Red
	hl(0, "RenderMarkdownH4Bg", { bg = "#1e1e2e", fg = "#cba6f7", bold = true }) -- Violet
	hl(0, "RenderMarkdownH5Bg", { bg = "#1e1e2e", fg = "#d5a8f8", bold = true }) -- Brighter Violet
	hl(0, "RenderMarkdownH6Bg", { bg = "#1e1e2e", fg = "#f5c2e7", bold = true }) -- Intense Magenta

	hl(0, "RenderMarkdownH1", { fg = "#89b4fa", bold = true }) -- Blue
	hl(0, "RenderMarkdownH2", { fg = "#a6e3a1", bold = true }) -- Green
	hl(0, "RenderMarkdownH3", { fg = "#f38ba8", bold = true }) -- Red
	hl(0, "RenderMarkdownH4", { fg = "#cba6f7", bold = true }) -- Violet
	hl(0, "RenderMarkdownH5", { fg = "#d5a8f8", bold = true }) -- Brighter Violet
	hl(0, "RenderMarkdownH6", { fg = "#f5c2e7", bold = true }) -- Intense Magenta

	-- Callouts
	hl(0, "RenderMarkdownInfo", { bg = "#1e1e2e", fg = "#89dceb" })
	hl(0, "RenderMarkdownSuccess", { bg = "#1e1e2e", fg = "#a6e3a1" })
	hl(0, "RenderMarkdownHint", { bg = "#1e1e2e", fg = "#94e2d5" })
	hl(0, "RenderMarkdownWarn", { bg = "#1e1e2e", fg = "#f9e2af" })
	hl(0, "RenderMarkdownError", { bg = "#1e1e2e", fg = "#f38ba8" })
	hl(0, "RenderMarkdownSubnote", { bg = "#313244", fg = "#a6adc8", italic = true })

	-- Bullets
	hl(0, "RenderMarkdownBullet", { fg = "#f5c2e7" })

	-- Code blocks
	hl(0, "@markup.raw.block.markdown", { fg = "#b4befe" }) -- catppuccin lavender

	-- Tables
	hl(0, "RenderMarkdownTableHead", { fg = "#89b4fa", bold = true })
	hl(0, "RenderMarkdownTableRow", { fg = "#cdd6f4" })
end

return M
