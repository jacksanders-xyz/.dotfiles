" PENCIL
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 84
augroup pencil
    autocmd!
    " autocmd FileType markdown,mkd,md call pencil#init()
    " autocmd FileType text call pencil#init({'wrap': 'hard'})
augroup END

" PENCIL HARD EVERYONE
nnoremap <leader>PH :PencilHard<CR>
nnoremap <leader>PS :PencilSoft<CR>
nnoremap <leader>PO :PencilOff<CR>

