lua require('jacksvimlua')

" TELESCOPE
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fn :lua require('jacksvimlua.telescope').search_notes()<CR>
nnoremap <leader>fs :lua require('jacksvimlua.telescope').grep_notes()<CR>
nnoremap <leader>fdf :lua require('jacksvimlua.telescope').search_dotfiles()<CR>
nnoremap <leader>fdg :lua require('jacksvimlua.telescope').grep_dotfiles()<CR>

nnoremap <leader>fps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>fpf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>fpw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fpb :lua require('telescope.builtin').buffers()<CR>

nnoremap <leader>GC :lua require('jacksvimlua.telescope').git_branches()<CR>

" nnoremap <leader>rr :lua require('jacksvimlua.telescope').refactors()<CR>
" vnoremap <leader>rr :lua require('jacksvimlua.telescope').refactors()<CR>
" nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
" nnoremap <leader>vrc :lua require('jacksvimlua.telescope').search_dotfiles()<CR>
" nnoremap <leader>va :lua require('theprimeagen.telescope').anime_selector()<CR>
" nnoremap <leader>vc :lua require('theprimeagen.telescope').chat_selector()<CR>
" nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
" nnoremap <leader>gm :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
