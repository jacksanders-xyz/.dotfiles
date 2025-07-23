-- SETS FOR NVIM
vim.opt.guicursor = ""

vim.opt.laststatus = 3

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.cmdheight = 1 -- GIVE MORE SPACE FOR DISPLAYING MESSAGES.

vim.opt.updatetime = 50
-- HAVING LONGER UPDATETIME (DEFAULT IS 4000 MS = 4 S) LEADS TO NOTICEABLE
-- DELAYS AND POOR USER EXPERIENCE.

vim.opt.shortmess:append("c") -- DON'T PASS MESSAGES TO |INS-COMPLETION-MENU|.
vim.opt.colorcolumn = "80"
