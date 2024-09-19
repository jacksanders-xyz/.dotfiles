-- SETS THE COLORS FOR THE HIGHLIGHT GROUPS

local colors = require("kanagawa.colors").setup({ theme='wave'})
-- local util = require("kanagawa.util")
-- util.lighten(colors.red1, 0.3)

vim.api.nvim_set_hl(0, 'VimwikiHeader2', {fg='#E6C384'})
vim.api.nvim_set_hl(0, 'VimwikiHeader3', {fg="#E46876"})
vim.api.nvim_set_hl(0, 'VimwikiHeader4', {fg="#0000ff"})
vim.api.nvim_set_hl(0, 'VimwikiHeader5', {fg="#FFA066"})
-- vim.api.nvim_set_hl(0, 'VimwikiHeader6', {fg=colors.orange})
