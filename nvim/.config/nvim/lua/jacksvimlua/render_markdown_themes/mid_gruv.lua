-- render-markdown highlights for mid-gruv (gruvbox-material soft dark, base #32302f)
local M = {}

function M.set_highlights()
	local hl = vim.api.nvim_set_hl

	-- Headers: band bg is gruvbox bg3 (#504945) over base #32302f
	hl(0, "RenderMarkdownH1Bg", { bg = "#504945", fg = "#7daea3", bold = true }) -- Aqua
	hl(0, "RenderMarkdownH2Bg", { bg = "#504945", fg = "#a9b665", bold = true }) -- Green
	hl(0, "RenderMarkdownH3Bg", { bg = "#504945", fg = "#ea6962", bold = true }) -- Red
	hl(0, "RenderMarkdownH4Bg", { bg = "#504945", fg = "#d3869b", bold = true }) -- Purple
	hl(0, "RenderMarkdownH5Bg", { bg = "#504945", fg = "#e78a4e", bold = true }) -- Orange
	hl(0, "RenderMarkdownH6Bg", { bg = "#504945", fg = "#d8a657", bold = true }) -- Yellow

	hl(0, "RenderMarkdownH1", { fg = "#7daea3", bold = true }) -- Aqua
	hl(0, "RenderMarkdownH2", { fg = "#a9b665", bold = true }) -- Green
	hl(0, "RenderMarkdownH3", { fg = "#ea6962", bold = true }) -- Red
	hl(0, "RenderMarkdownH4", { fg = "#d3869b", bold = true }) -- Purple
	hl(0, "RenderMarkdownH5", { fg = "#e78a4e", bold = true }) -- Orange
	hl(0, "RenderMarkdownH6", { fg = "#d8a657", bold = true }) -- Yellow

	-- Callouts
	hl(0, "RenderMarkdownInfo", { bg = "#504945", fg = "#7daea3" })    -- Aqua
	hl(0, "RenderMarkdownSuccess", { bg = "#504945", fg = "#a9b665" }) -- Green
	hl(0, "RenderMarkdownHint", { bg = "#504945", fg = "#89b482" })    -- Dark Aqua
	hl(0, "RenderMarkdownWarn", { bg = "#504945", fg = "#d8a657" })    -- Yellow
	hl(0, "RenderMarkdownError", { bg = "#504945", fg = "#ea6962" })   -- Red
	hl(0, "RenderMarkdownSubnote", { bg = "#45403d", fg = "#a89984", italic = true }) -- bg_dim, fg4

	-- Bullets
	hl(0, "RenderMarkdownBullet", { fg = "#e78a4e" }) -- Orange

	-- Code blocks
	hl(0, "@markup.raw.block.markdown", { fg = "#d3869b" }) -- Purple

	-- Tables
	hl(0, "RenderMarkdownTableHead", { fg = "#7daea3", bold = true }) -- Aqua
	hl(0, "RenderMarkdownTableRow", { fg = "#d4be98" })              -- fg0
end

return M
