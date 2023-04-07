local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

nnoremap('J', function()
    local word = '<S-DOWN>'
    local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"..word
    string_prep = string_prep..word.."',true,false,true),'m',true)"
    vim.api.nvim_command(string_prep)
end
)

nnoremap('K', function()
    local word = '<S-UP>'
    local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"..word
    string_prep = string_prep..word.."',true,false,true),'m',true)"
    vim.api.nvim_command(string_prep)
end
)
