lua require('jacksvimlua')

" TELESCOPE GENERAL
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" CUSTOM LOOKIN AROUND
nnoremap <leader>fn :lua require('jacksvimlua.telescope').search_notes()<CR>
nnoremap <leader>fs :lua require('jacksvimlua.telescope').grep_notes()<CR>
nnoremap <leader>fdf :lua require('jacksvimlua.telescope').search_dotfiles()<CR>
nnoremap <leader>fdg :lua require('jacksvimlua.telescope').grep_dotfiles({ hidden = true })<CR>

" QF
nnoremap <leader>fps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <leader>fpw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>fpb :lua require('telescope.builtin').buffers()<CR>

" GIT
nnoremap <leader>gc :lua require('jacksvimlua.telescope').git_branches()<CR>
nnoremap <leader>gC :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>gBC :lua require('telescope.builtin').git_bcommits()<CR>
nnoremap <leader>gS :lua require('telescope.builtin').git_status()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>gM :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
