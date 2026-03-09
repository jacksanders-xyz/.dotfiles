-- render-markdown highlights for morning (dayfox, transparent over terminal bg #b3b3b3)
local M = {}

function M.set_highlights()
	local hl = vim.api.nvim_set_hl

	-- Headers: band bg #969eac (blue-grey, darker than terminal #b3b3b3)
	-- Foreground colours: bright dayfox variants for vibrant contrast
	hl(0, "RenderMarkdownH1Bg", { bg = "#969eac", fg = "#2e5a9e", bold = true }) -- Deep Blue
	hl(0, "RenderMarkdownH2Bg", { bg = "#969eac", fg = "#3a7a50", bold = true }) -- Rich Green
	hl(0, "RenderMarkdownH3Bg", { bg = "#969eac", fg = "#c73b5e", bold = true }) -- Vivid Red
	hl(0, "RenderMarkdownH4Bg", { bg = "#969eac", fg = "#7b4b9e", bold = true }) -- Deep Magenta
	hl(0, "RenderMarkdownH5Bg", { bg = "#969eac", fg = "#9554b5", bold = true }) -- Vivid Violet
	hl(0, "RenderMarkdownH6Bg", { bg = "#969eac", fg = "#cc5a9a", bold = true }) -- Hot Pink

	hl(0, "RenderMarkdownH1", { fg = "#2e5a9e", bold = true }) -- Deep Blue
	hl(0, "RenderMarkdownH2", { fg = "#3a7a50", bold = true }) -- Rich Green
	hl(0, "RenderMarkdownH3", { fg = "#c73b5e", bold = true }) -- Vivid Red
	hl(0, "RenderMarkdownH4", { fg = "#7b4b9e", bold = true }) -- Deep Magenta
	hl(0, "RenderMarkdownH5", { fg = "#9554b5", bold = true }) -- Vivid Violet
	hl(0, "RenderMarkdownH6", { fg = "#cc5a9a", bold = true }) -- Hot Pink

	-- Callouts
	hl(0, "RenderMarkdownInfo", { bg = "#969eac", fg = "#2e5a9e" })    -- Deep Blue
	hl(0, "RenderMarkdownSuccess", { bg = "#969eac", fg = "#3a7a50" }) -- Rich Green
	hl(0, "RenderMarkdownHint", { bg = "#969eac", fg = "#3d8a84" })    -- Vivid Cyan
	hl(0, "RenderMarkdownWarn", { bg = "#969eac", fg = "#9a5c14" })    -- Deep Amber
	hl(0, "RenderMarkdownError", { bg = "#969eac", fg = "#c73b5e" })   -- Vivid Red
	hl(0, "RenderMarkdownSubnote", { bg = "#8b93a1", fg = "#2a4a6a", italic = true })

	-- Bullets
	hl(0, "RenderMarkdownBullet", { fg = "#c73b5e" }) -- Vivid Red

	-- Code blocks
	hl(0, "@markup.raw.block.markdown", { fg = "#2e5a9e" }) -- Deep Blue

	-- Tables
	hl(0, "RenderMarkdownTableHead", { fg = "#2e5a9e", bold = true }) -- Deep Blue
	hl(0, "RenderMarkdownTableRow", { fg = "#1d344f" })              -- fg1 (dark)
end

return M
