local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
require('orgmode').setup({
    org_agenda_files = {'~/orgmodefiles/**/*'},

    org_default_notes_file = '~/orgmodefiles/notes.org',
    mappings = {
        global = {
            org_capture = '<leader>OC',
        },
    }
})

-- SEE ALL THE TODO's
nnoremap('<leader>ot', '<Cmd>lua require("orgmode").action("agenda.prompt")<CR>t')

-- NEW TODO
nnoremap('<leader>oc', '<Cmd>lua require("orgmode").action("capture.prompt")<CR>t')
