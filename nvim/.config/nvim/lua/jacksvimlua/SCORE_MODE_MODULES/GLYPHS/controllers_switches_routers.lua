return {
    ['<C-f>'] = {
      ['rhs'] = ':lua enter_NF()<CR>',
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

