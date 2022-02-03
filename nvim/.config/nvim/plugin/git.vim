" FUGITIVE
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Git<CR> " Views status, use `-` and `p` to add/remove files
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gg :Gcommit -v -q %:p<CR> " Commits current file
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gm :Git merge<CR>

nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>

" GIT WORKTREE
