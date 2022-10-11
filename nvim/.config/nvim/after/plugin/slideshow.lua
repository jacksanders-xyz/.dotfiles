local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local api = vim.api

-- START UP A SLIDESHOW
-- IF YOU AR GOING TO DO WITH ZEN MODE, DO THAT FIRST
nnoremap("<leader>wk", function()
    local command = 'KKSlider '..vim.fn.expand('%:p')
    api.nvim_command(command)
end)
