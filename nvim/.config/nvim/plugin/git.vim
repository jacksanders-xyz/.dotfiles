" FUGITIVE
nnoremap <leader>gs :Git<CR> " Views status, use `-` and `p` to add/remove files
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gfa :Git fetch --all<CR>
nnoremap <leader>gfp :Git fetch --prune<CR>
nnoremap <leader>grum :Git rebase upstream/master<CR>
nnoremap <leader>grom :Git rebase origin/master<CR>
nnoremap <leader>gm :Git merge mybranch
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

nnoremap <leader>gdrb :Git push --delete origin mybranch


" nnoremap <leader>gd :Git diff<CR>
" nnoremap <leader>gc :Git commit -v -q<CR>
" nnoremap <leader>gg :Git commit -v -q %:p<CR> " Commits current file

" GIT WORKTREES
