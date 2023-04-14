local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

nnoremap('J', function()
    local word = '<s-down>'
    local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"
    string_prep = string_prep..word.."',true,false,true),'m',true)"
    vim.api.nvim_command(string_prep)
end,
    {
        silent = true,
        buffer=true
    })

nnoremap('K', function()
    local word = '<s-up>'
    local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"
    string_prep = string_prep..word.."',true,false,true),'m',true)"
    vim.api.nvim_command(string_prep)
end, {
        silent = true,
        buffer=true
    })


local autocmd = vim.api.nvim_create_autocmd
local org_group = vim.api.nvim_create_augroup("orgfile_group", {clear = true})

-- autocmd({'BufWritePost * !run_tests.sh ~/orgfiles/recurring.org'})
-- autocmd({'BufWritePost * !osascript -e 'tell application "Übersicht" to refresh widget id "task_lister"' ~/orgfiles/work.org'})
-- autocmd({'BufWritePost * echom 'hello world' /Users/jsanders/orgfiles/work.org'})

autocmd("BufWritePost" , {
    pattern = "/Users/jsanders/orgfiles/*.org",
    command = "!osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"task_lister-index-jsx\"'",
    group = org_group,
})
-- autocmd("BufWritePost" , {
--     pattern = "/Users/jsanders/orgfiles/*.org",
--     command = "!osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh'",
--     group = org_group,
-- })

