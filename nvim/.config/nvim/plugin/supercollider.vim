" SUPERCOLLIDER
lua << EOF
local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr
scnvim.setup {
  keymaps = {
    ['<leader>SL'] = map('editor.send_line', {'i', 'n'}),
    ['<C-e>'] = {
      map('editor.send_block', {'i', 'n'}),
      map('editor.send_selection', 'x'),
    },
    ['<CR>'] = map('postwin.toggle'),
    ['<leader>SS'] = map('sclang.start'),
    ['<leader>Sk'] = map('signature.show', {'n', 'i'}),
    ['<leader>S>'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
    ['<leader>SR'] = map('sclang.recompile'),
    ['<leader>SB'] = map_expr('s.boot'),
    ['<leader>SC'] = map('postwin.clear', {'n', 'i'}),
    ['<leader>SM'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
      color = 'IncSearch',
    },
  },
  postwin = {
    float = {
      enabled = false,
    },
  },

}
EOF
