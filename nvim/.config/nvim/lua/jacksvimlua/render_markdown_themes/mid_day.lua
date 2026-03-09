-- render-markdown highlights for mid-day (catppuccin frappe, base #303446)
local M = {}

function M.set_highlights()
	local hl = vim.api.nvim_set_hl

	-- Headers: band bg is frappe surface0 (#414559) over base #303446
	hl(0, "RenderMarkdownH1Bg", { bg = "#414559", fg = "#8caaee", bold = true }) -- Blue
	hl(0, "RenderMarkdownH2Bg", { bg = "#414559", fg = "#a6d189", bold = true }) -- Green
	hl(0, "RenderMarkdownH3Bg", { bg = "#414559", fg = "#e78284", bold = true }) -- Red
	hl(0, "RenderMarkdownH4Bg", { bg = "#414559", fg = "#ca9ee6", bold = true }) -- Mauve
	hl(0, "RenderMarkdownH5Bg", { bg = "#414559", fg = "#f4b8e4", bold = true }) -- Pink
	hl(0, "RenderMarkdownH6Bg", { bg = "#414559", fg = "#f2d5cf", bold = true }) -- Rosewater

	hl(0, "RenderMarkdownH1", { fg = "#8caaee", bold = true }) -- Blue
	hl(0, "RenderMarkdownH2", { fg = "#a6d189", bold = true }) -- Green
	hl(0, "RenderMarkdownH3", { fg = "#e78284", bold = true }) -- Red
	hl(0, "RenderMarkdownH4", { fg = "#ca9ee6", bold = true }) -- Mauve
	hl(0, "RenderMarkdownH5", { fg = "#f4b8e4", bold = true }) -- Pink
	hl(0, "RenderMarkdownH6", { fg = "#f2d5cf", bold = true }) -- Rosewater

	-- Callouts
	hl(0, "RenderMarkdownInfo", { bg = "#414559", fg = "#99d1db" })    -- Sky
	hl(0, "RenderMarkdownSuccess", { bg = "#414559", fg = "#a6d189" }) -- Green
	hl(0, "RenderMarkdownHint", { bg = "#414559", fg = "#81c8be" })    -- Teal
	hl(0, "RenderMarkdownWarn", { bg = "#414559", fg = "#e5c890" })    -- Yellow
	hl(0, "RenderMarkdownError", { bg = "#414559", fg = "#e78284" })   -- Red
	hl(0, "RenderMarkdownSubnote", { bg = "#51576d", fg = "#b5bfe2", italic = true }) -- surface1, subtext1

	-- Bullets
	hl(0, "RenderMarkdownBullet", { fg = "#f4b8e4" }) -- Pink

	-- Code blocks
	hl(0, "@markup.raw.block.markdown", { fg = "#babbf1" }) -- Lavender

	-- Tables
	hl(0, "RenderMarkdownTableHead", { fg = "#8caaee", bold = true }) -- Blue
	hl(0, "RenderMarkdownTableRow", { fg = "#c6d0f5" })              -- Text
end

return M
