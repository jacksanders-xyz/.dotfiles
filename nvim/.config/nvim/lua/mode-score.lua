local libmodal = require('libmodal')
local popup = require("plenary.popup")

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

function talk()
  -- vim.g.MI = runningMap
  vim.g.MI = "hey hello"
  api.nvim_command("echom g:MI")
end

function create_cw()
    local width = 60
    local height = 10
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = api.nvim_create_buf(false, false)
    local Chord_win_id, win = popup.create(bufnr, {
        title = "Chord",
        highlight = "ChordWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minheight = height,
        minwidth = width,
        borderchars = borderchars,
    })

    api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:ChordBorder"
    )

    return {
        bufnr = bufnr,
        win_id = Chord_win_id,
    }
end

local function close_menu()
    api.nvim_win_close(Chord_win_id, true)
    Chord_win_id = nil
    Chord_bufh = nil
end

-- local function open_menu()
--     api.nvim_open_win(Chord_win_id, true)
-- end

function toggle_fwin()
    if Chord_win_id ~= nil and api.nvim_win_is_valid(Chord_win_id) then
        close_menu()
        return
    end

    -- if Chord_win_id ~= nil then
    --     open_menu()
    --     return
    -- end 
      
    local win_info = create_cw()
    local contents = {}

    Chord_win_id = win_info.win_id
    Chord_bufh = win_info.bufnr

    api.nvim_win_set_option(Chord_win_id, "number", true)
    api.nvim_buf_set_name(Chord_bufh, "chord_menu")
    -- api.nvim_buf_set_lines(Chord_bufh, 0, 10, false, contents)
    api.nvim_buf_set_option(Chord_bufh, "filetype", "vimwiki")
    -- api.nvim_buf_set_option(Chord_bufh, "buftype", "acwrite")
    api.nvim_buf_set_option(Chord_bufh, "bufhidden", "delete")
    api.nvim_buf_set_keymap(
        Chord_bufh,
        "n",
        "q",
        ":lua toggle_fwin()<CR>",
        { silent = true }
    )
end

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

function chord_constructor(chord_num)
  local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('q:norm i"..staff_instruction
  string_prep = string_prep.."<cr>A<tab>',true,false,true),'m',true)"
  api.nvim_command(string_prep)
end

function snip_builder_func(staff_instruction)
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
