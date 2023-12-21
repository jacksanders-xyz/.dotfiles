-- SETS THE COLORS FOR THE HIGHLIGHT GROUPS

local colors = require("tokyonight.colors").setup({})
local util = require("tokyonight.util")
-- util.lighten(colors.red1, 0.3)

vim.api.nvim_set_hl(0, 'VimwikiHeader2', {fg=colors.yellow})
vim.api.nvim_set_hl(0, 'VimwikiHeader3', {fg='#98971a',bg=util.darken(colors.fg, 0.1)})
vim.api.nvim_set_hl(0, 'VimwikiHeader4', {fg='#0000ff',bg=util.darken(colors.fg, 0.1)})
vim.api.nvim_set_hl(0, 'VimwikiHeader5', {fg=colors.red1,bg=colors.cyan})
-- vim.api.nvim_set_hl(0, 'VimwikiHeader6', {fg=colors.orange})
