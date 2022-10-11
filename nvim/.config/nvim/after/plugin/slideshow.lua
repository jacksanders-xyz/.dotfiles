local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local api = vim.api

-- START UP A SLIDESHOW
-- IF YOU AR GOING TO DO WITH ZEN MODE, DO THAT FIRST
nnoremap("<leader>wk", function()
    local currPath = vim.fn.expand('%:p')
    local command = 'KKSlider '..currPath
    api.nvim_command(command)
end)
