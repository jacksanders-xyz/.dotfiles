return {
    -- make a black note

    -- This is the note with the ligature in it down 3 to line up with the cursor
    -- "note normal" L3
    -- U+EB9A staffPosLower3
    ['nn'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },
    -- "note low" l4
    -- U+EB9B staffPosLower4
    ['nj'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },
    -- "note high 1" L2
    -- U+EB99 staffPosLower2
    ['nk'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },

    -- HALF NOTES
    -- U+EB9A staffPosLower3
    ['<C-h>n'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },
    -- "note low"
    -- U+EB9B staffPosLower4
    ['<C-h>j'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },
    -- "note high 1"
    -- U+EB99 staffPosLower2
    ['<C-h>k'] = {
      ['rhs'] = 'vlc<Esc>h',
      ['noremap'] = true,
      ['silent'] = true
    },

   -- MUSICAL SYMBOL WHOLE NOTE
   -- Unicode: U+1D15D, UTF-8: F0 9D 85 9D
    -- ['wn'] = {
    --   ['rhs'] = 'vc𝅝<Esc>',
    --   ['noremap'] = true,
    --   ['silent'] = true
    -- },
    -- "note low"
    -- U+EB9B staffPosLower4
    -- [''] = {
    --   ['rhs'] = 'vlc<Esc>h',
    --   ['noremap'] = true,
    --   ['silent'] = true
    -- },
    -- -- "note high 1"
    -- -- U+EB99 staffPosLower2
    -- [''] = {
    --   ['rhs'] = 'vlc<Esc>h',
    --   ['noremap'] = true,
    --   ['silent'] = true
    -- },
}

