local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
require('orgmode').setup({
    org_agenda_files = {'~/OrgmodeFiles/orgAgenda/**/*'},
    org_default_notes_file = '~/OrgmodeFiles/org/notes.org',
    mappings = {
        global = {
        org_capture = '<leader>OC',
        -- org_agenda = '<leader>OA'
        }
    }
})
nnoremap('<leader>ot', '<Cmd>lua require("orgmode").action("agenda.prompt")<CR>t')
nnoremap('<leader>oc', '<Cmd>lua require("orgmode").action("capture.prompt")<CR>t')
