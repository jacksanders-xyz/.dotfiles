local numbers_gylphs = require('jacksvimlua.SCORE_MODE_MODULES.GLYPHS.numbers_glyphs')
local notes_glyphs = require('jacksvimlua.SCORE_MODE_MODULES.GLYPHS.notes_glyphs')
local sharps_flats_accidentals = require('jacksvimlua.SCORE_MODE_MODULES.GLYPHS.sharps_flats_accidentals')
local controllers_switches_routers = require('jacksvimlua.SCORE_MODE_MODULES.GLYPHS.controllers_switches_routers')
local clefs_staffs_barlines = require('jacksvimlua.SCORE_MODE_MODULES.GLYPHS.clefs_staffs_barlines')

local collect_tables = {
  numbers_gylphs,
  notes_glyphs,
  sharps_flats_accidentals,
  controllers_switches_routers,
  clefs_staffs_barlines,
}

return function()
  local MasterTable = {
    ['n'] = {}
  }
    for table,tableValue in pairs(collect_tables) do
      for key,value in pairs(tableValue) do
        MasterTable['n'][key] = value
      end
    end
  return MasterTable
end


-- tables of glyphs:
-- local activeMap = require('jacksvimlua.SCORE_MODE_MODULES.numbers_glyphs')

-- local table_copy = require('jacksvimlua.SCORE_MODE_MODULES.table_copy')
-- local runningMap2 = table_copy(activeMap)


-- local
-- return function()
--   return {}
-- end

-- return {
--  ['n'] = {
--      ['<C-f>'] = {
--        ['rhs'] = ':lua enter_NF()<CR>',
--        ['noremap'] = true
--      },
--      ['<C-s>'] = {
--        ['rhs'] = ':lua enter_SC()<CR>',
--        ['noremap'] = true
--      },
--      ['<Esc>'] = {
--        ['rhs'] = ':lua exit_SL()<CR>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--     -- move fast
--      ['L'] = {
--        ['rhs'] = 'llllll',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      ['H'] = {
--        ['rhs'] = 'hhhhhh',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- make a black note
--
--      -- This is the note with the ligature in it down 3 to line up with the cursor
--      -- "note normal" L3
--      -- U+EB9A staffPosLower3
--      ['nn'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note low" l4
--      -- U+EB9B staffPosLower4
--      ['nj'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note high 1" L2
--      -- U+EB99 staffPosLower2
--      ['nk'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- sharp
--      -- "sharp normal" L3
--      -- U+EB9A staffPosLower3
--      ['sn'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note low" l4
--      -- U+EB9B staffPosLower4
--      ['sj'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note high 1" L2
--      -- U+EB99 staffPosLower2
--      ['sk'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },

--      -- flat
--      -- "sharp normal" L3
--      -- U+EB9A staffPosLower3
--      ['fn'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note low" l4
--      -- U+EB9B staffPosLower4
--      ['fj'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note high 1" L2
--      -- U+EB99 staffPosLower2
--      ['fk'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },

--      -- HALF NOTES
--      -- U+EB9A staffPosLower3
--      ['<C-h>n'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note low"
--      -- U+EB9B staffPosLower4
--      ['<C-h>j'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- "note high 1"
--      -- U+EB99 staffPosLower2
--      ['<C-h>k'] = {
--        ['rhs'] = 'vlc<Esc>h',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--     --
--     -- MUSICAL SYMBOL WHOLE NOTE
--     -- Unicode: U+1D15D, UTF-8: F0 9D 85 9D
--      -- ['wn'] = {
--      --   ['rhs'] = 'vc𝅝<Esc>',
--      --   ['noremap'] = true,
--      --   ['silent'] = true
--      -- },
--      -- "note low"
--      -- U+EB9B staffPosLower4
--      -- [''] = {
--      --   ['rhs'] = 'vlc<Esc>h',
--      --   ['noremap'] = true,
--      --   ['silent'] = true
--      -- },
--      -- -- "note high 1"
--      -- -- U+EB99 staffPosLower2
--      -- [''] = {
--      --   ['rhs'] = 'vlc<Esc>h',
--      --   ['noremap'] = true,
--      --   ['silent'] = true
--      -- },
--      -- Treble clef
--      ['cg'] = {
--        ['rhs'] = 'r<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- F clef
--      ['cf'] = {
--        ['rhs'] = 'r<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- staff
--      ['s'] = {
--        ['rhs'] = 'i<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- heavy barline
--      ['bh'] = {
--        ['rhs'] = 'r<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      -- light barline
--      ['bl'] = {
--        ['rhs'] = 'r<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      ['ct'] = {
--        ['rhs'] = 'vlc<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      ['3'] = {
--        ['rhs'] = 'vlc<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--      ['4'] = {
--        ['rhs'] = 'vlc<Esc>',
--        ['noremap'] = true,
--        ['silent'] = true
--      },
--    }
--}
