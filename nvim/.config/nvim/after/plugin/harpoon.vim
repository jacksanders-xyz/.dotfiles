lua require('jacksvimlua')

" Terminal commands
" ueoa is first through fourth finger left hand home row.
" This just means I can crush, with opposite hand, the 4 terminal positions

" These functions are stored in harpoon.  A plugn that I am developing
nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-a> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><C-h> :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><C-t> :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><C-n> :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><C-s> :lua require("harpoon.ui").nav_file(4)<CR>

" TERMINAL STUFF
" nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
" nnoremap <silent><leader>tu :lua require("harpoon.tmux").gotoTerminal("TEST")<CR>
" nnoremap <silent><leader>te :lua require("harpoon.tmux").gotoTerminal(2)<CR>
" nnoremap <silent><leader>cu :lua require("harpoon.tmux").sendCommand("TEST", "ls -la")<CR>
" nnoremap <silent><leader>ce :lua require("harpoon.tmux").sendCommand("TEST", 1)<CR>
