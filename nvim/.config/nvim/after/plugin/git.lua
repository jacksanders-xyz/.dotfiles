-- FUGITIVE
local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local nmap = Remap.nmap

nnoremap("<leader>gs", ":Git<CR>")
nnoremap("<leader>ga", ":Git add %:p<CR><CR>")
nnoremap("<leader>gp", ":Git push<CR>")
nnoremap("<leader>gum", ":Git push --set-upstream origin mybranch")
nnoremap("<leader>gfa", ":Git fetch --all<CR>")
nnoremap("<leader>gfp", ":Git fetch --prune<CR>")
nnoremap("<leader>grum", ":Git rebase upstream/master<CR>")
nnoremap("<leader>grom", ":Git rebase origin/master<CR>")
nnoremap("<leader>gm", ":Git merge mybranch")
nmap("<leader>gh", ":diffget //3<CR>")
nmap("<leader>gu", ":diffget //2<CR>")

nnoremap("<leader>gdrb", ":Git push -- delete origin mybranch")
nnoremap("<leader>gd", ":Git diff<CR>")
nnoremap("<leader>gc", ":Git commit -v -q<CR>")

-- Commits current file
nnoremap("<leader>gg", ":Git commit -v -q %:p<CR> ")

-- GIT WORKTREE