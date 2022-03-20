local libmodal = require('libmodal')
local popup = require("plenary.popup")
local api = vim.api
vim.g.LastImagePath = ''

local function close_menu()
    api.nvim_win_close(Iff_win_id, true)
    Iff_win_id = nil
    Iff_bufh = nil
end

local function create_cw()
    local width = 200
    local height = 1
    local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    local bufnr = api.nvim_create_buf(false, false)
    local Iff_win_id, win = popup.create(bufnr, {
        title = "Path to Image",
        highlight = "IffWindow",
        line = math.floor(((vim.o.lines - height) / 2) - 1),
        col = math.floor((vim.o.columns - width) / 2),
        minheight = height,
        minwidth = width,
        borderchars = borderchars,
    })

    api.nvim_win_set_option(
        win.border.win_id,
        "winhl",
        "Normal:IffBorder"
    )
    return {
        bufnr = bufnr,
        win_id = Iff_win_id,
    }
end


local function toggle_fwin(currPath)
    if currPath == "" then
        close_menu()
        return
    end

    local win_info = create_cw()

    local contents = {}
    -- if vim.g.LastImagePath ~= '' then
    -- end
    -- api.nvim_command("let g:IPAcurrPath = expand('%:p')")
    -- local currPath = vim.g.IPAcurrPath
    contents[1] = currPath

    Iff_win_id = win_info.win_id
    Iff_bufh = win_info.bufnr

    api.nvim_win_set_option(Iff_win_id, "number", true)
    api.nvim_buf_set_name(Iff_bufh, "iff_menu")
    api.nvim_buf_set_lines(Iff_bufh, 0, #contents, false, contents)
    api.nvim_buf_set_option(Iff_bufh, "filetype", "vimwiki")
    -- api.nvim_buf_set_option(Iff_bufh, "buftype", "acwrite")
    api.nvim_buf_set_option(Iff_bufh, "bufhidden", "delete")
    api.nvim_buf_set_keymap(
        Iff_bufh,
        "n",
        "q",
        ":lua require('jacksvimlua.ImagePathAutomator').toggle_fwin('')<CR>",
        { silent = true }
    )
    api.nvim_buf_set_keymap(
        Iff_bufh,
        "i",
        "<c-f>",
        "<Esc>:lua require('jacksvimlua.ImagePathAutomator').Reformat_and_put('LOCAL')<CR>",
        { silent = true }
    )
    api.nvim_buf_set_keymap(
        Iff_bufh,
        "i",
        "<C-j>",
        "<Esc>:lua require('jacksvimlua.ImagePathAutomator').Reformat_and_put('JACKS_BRAIN')<CR>",
        { silent = true }
    )
    api.nvim_buf_set_keymap(
        Iff_bufh,
        "i",
        "<C-w>",
        "<Esc>:lua require('jacksvimlua.ImagePathAutomator').Reformat_and_put('WORK')<CR>",
        { silent = true }
    )
end
 -- ![](path/to/image)
-- [alt text](https://github.com/[username]/[reponame]/blob/[branch]/image.jpg?raw=true)
-- https://github.com/jacksanders-xyz/images4jacks_brain/blob/main/TEST/Screen%20Shot%202021-08-11%20at%201.23.17%20PM.png?

-- https://github.com/jacksanders-xyz/images4jacks_brain/blob/main/TEST/Screen%20Shot%202021-08-11%20at%201.23.17%20PM.png
local function Reformat_and_put(REFORMAT_TYPE)
    local ACTION
    local GIT_JACKS_BRAIN_LOCATION_START = 'https://github.com/jacksanders-xyz/images4jacks_brain/blob/main'
    -- local GIT_WORK_LOCATION = 'https://github.com/jacksanders-xyz/images4jacks_brain/blob/main/TEST/Screen%20Shot%202021-08-11%20at%201.23.17%20PM.png?'
    if REFORMAT_TYPE == "JACKS_BRAIN" then
        ACTION = ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>?jacks_brain<CR>f/d0$vF/l\"ay fr /%20/g<cr>$a?raw=true)<Esc>I<c-r>a]<esc>I![<Esc>f]a("..GIT_JACKS_BRAIN_LOCATION_START.."<Esc>Vyqp',true,false,true),'m',true)"
    elseif REFORMAT_TYPE == "WORK" then
        ACTION = ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>$vT/\"ayyss(lx$hxI![<C-r>a]<esc>V\"ayq\"ap',true,false,true),'m',true)"
    else
        ACTION = ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>$vT/\"ayyss(lx$hxI![<C-r>a]<esc>Vyqp',true,false,true),'m',true)"
    end
    api.nvim_command(ACTION)
end

-- THIS IS THE FUNCTION FOR THE TELEMODULE...
local function Telescope_Path_Constructor(PATH, DESTINATION)
    toggle_fwin(PATH)
    local reformat = ":lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>I~/VimWiki/IMAGE_POOL/<Esc>$a',true,false,true),'m',true)"
    api.nvim_command(reformat)
    Reformat_and_put(DESTINATION)
end


local function formatAndToggle()
    local currPath = vim.fn.expand('%:p')
    toggle_fwin(currPath)
    local Action = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('/VimWiki<CR>hc0~<Esc>/jacks_brain<CR>iIMAGE_POOL/<Esc>lC',true,false,true),'m',true)"
    api.nvim_command(Action)
end

local function ImagePathFind()
    formatAndToggle()
end

return {
    toggle_fwin = toggle_fwin,
    create_cw = create_cw,
    close_menu = close_menu,
    formatAndToggle = formatAndToggle,
    ImagePathFind = ImagePathFind,
    Reformat_and_put = Reformat_and_put,
    Telescope_Path_Constructor = Telescope_Path_Constructor
}
