return {
    -- ['<C-g>'] = {
    --   ['rhs'] = ':lua enter_CF()<CR>',
    --   ['noremap'] = true
    -- },
    ['<C-g>'] = {
      ['rhs'] = ':lua chord_constructor("CF_7", "7")<CR>',
      ['noremap'] = true
    },
    ['<C-s>'] = {
      ['rhs'] = ':lua enter_SC()<CR>',
      ['noremap'] = true
    },
    ['<Esc>'] = {
      ['rhs'] = ':lua exit_SL()<CR>',
      ['noremap'] = true,
      ['silent'] = true
    },
   -- move fast
    ['L'] = {
      ['rhs'] = 'llllll',
      ['noremap'] = true,
      ['silent'] = true
    },
    ['H'] = {
      ['rhs'] = 'hhhhhh',
      ['noremap'] = true,
      ['silent'] = true
    },
}

