local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
require('orgmode').setup({
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfiles/refile.org',
    org_hide_emphasis_markers = true,
    org_agenda_text_search_extra_files = { 'agenda-archives' },
    org_agenda_start_on_weekday = false,
    -- org_todo_keywords = { 'TODO(t)', 'PROGRESS(p)', '|', 'DONE(d)', 'REJECTED(r)' },
    org_capture_templates = {
        t = {
            description = 'Refile',
            template = '* TODO %?\n  DEADLINE: %T',
        },
        T = {
            description = 'Todo',
            template = '* TODO %?\n  DEADLINE: %T',
            target = '~/orgfiles/todos.org',
        },
        w = {
            description = 'Work todo',
            template = '* TODO %?\n  DEADLINE: %T',
            target = '~/orgfiles/work.org',
        },
        d = {
            description = 'Daily',
            template = '* Daily %U \n  %?',
            target = '~/orgfiles/work.org',
            headline = 'Meetings',
        },
    },
    mappings = {
        global = {
            org_capture = '<leader>OC',
        },
    }
})

-- SEE ALL THE TODO's
nnoremap('<leader>ot', '<Cmd>lua require("orgmode").action("agenda.prompt")<CR>a')
nnoremap('<leader>OT', '<Cmd>lua require("orgmode").action("agenda.prompt")<CR>t')

-- NEW TODO
nnoremap('<leader>oc', '<Cmd>lua require("orgmode").action("capture.prompt")<CR>w')
