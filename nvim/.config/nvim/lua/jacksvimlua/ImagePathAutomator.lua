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
    local width = 130
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
    if Iff_win_id ~= nil and api.nvim_win_is_valid(Iff_win_id) then
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
        ":lua require('jacksvimlua.ImagePathAutomator').formatAndToggle()<CR>",
        { silent = true }
    )
end

local function formatAndToggle()
    local currPath = vim.fn.expand('%:p')
    -- local currPath = "hey"
    toggle_fwin(currPath)
end

local function ImagePathFind()
    formatAndToggle()
end

return {
    toggle_fwin = toggle_fwin,
    create_cw = create_cw,
    close_menu = close_menu,
    formatAndToggle = formatAndToggle,
    ImagePathFind = ImagePathFind
}
