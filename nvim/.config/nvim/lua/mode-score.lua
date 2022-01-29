local libmodal = require('libmodal')

local scoreMaps = require('jacksvimlua.SCORE_MODE_MODULES.MODE_MAPS.scoreMaps')()

local staffConstructorMaps = require('jacksvimlua.SCORE_MODE_MODULES.MODE_MAPS.staffConstructorMaps')
local chordFloatMaps = require('jacksvimlua.SCORE_MODE_MODULES.MODE_MAPS.chordFloatMaps')

local unMap = require('jacksvimlua.SCORE_MODE_MODULES.UTILITY_FUNCTIONS.unMap')
local reMap = require('jacksvimlua.SCORE_MODE_MODULES.UTILITY_FUNCTIONS.reMap')
local table_copy = require('jacksvimlua.SCORE_MODE_MODULES.UTILITY_FUNCTIONS.table_copy')

local runningMap = table_copy(scoreMaps)
local modeIdentifier = 'score'
local api = vim.api
local score_layer = libmodal.Layer.new(runningMap)
local chord_float = libmodal.Mode.new('CHORD FLOAT', chordFloatMaps)

-- function talk()
  -- vim.g.MI = runningMap
  -- api.nvim_command("echom g:MI")
-- end

function set_coordinates()
  api.nvim_command("set cursorline")
  api.nvim_command("set cursorcolumn")
end

function kill_coordinates()
  api.nvim_command("set nocursorline")
  api.nvim_command("set nocursorcolumn")
end

function exit_SL()
  unMap(score_layer)
  api.nvim_command("set colorcolumn=")
end

function re_entry_SL()
  reMap(score_layer)
  api.nvim_command("set colorcolumn=149")
end

function exit_CF()
  chord_float:exit()
  modeIdentifier = 'score'
  handlerFunction()
end

function enter_CF()
  modeIdentifier = 'chord_float'
  handlerFunction()
end

function enter_SC()
  modeIdentifier = 'staff_constructor'
  set_coordinates()
  vim.g.staffModeExit = false
  handlerFunction()
  -- kill_coordinates()
end

function exit_SC()
  vim.g.staffModeExit = true
  modeIdentifier = 'score'
  kill_coordinates()
  -- handlerFunction()
end

function staff_builder_func(staff_instruction)
  local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('q:norm i"..staff_instruction
  string_prep = string_prep.."<cr>A<tab>',true,false,true),'m',true)"
  api.nvim_command(string_prep)
end

function handlerFunction()
  if(modeIdentifier == 'score')
    then
      score_layer:enter()
  elseif(modeIdentifier == 'chord_float')
    then
      chord_float:enter()
  elseif(modeIdentifier == 'staff_constructor')
    then
      libmodal.mode.enter('STAFF', staffConstructorMaps, true)
    end
end

return function()
  api.nvim_command("set colorcolumn=149")
  handlerFunction()
end
