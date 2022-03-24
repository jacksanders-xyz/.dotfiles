" ~THEMES AND COLORS~
fun! ColorMyPencils()
    set background=dark
    lua require('colorbuddy').colorscheme('gruvbuddy')
    :hi WinSeparator guibg=none
    " let g:airline_powerline_fonts=1
    " let g:airline#extensions#tabline#enabled = 1
    " let g:airline#extensions#tabline#left_sep = ' '
    " let g:airline#extensions#tabline#left_alt_sep = '|'
    " let g:airline_theme='base16_gruvbox_dark_pale'
endfun
call ColorMyPencils()

" base16_gruvbox_dark_pale

" hi! link markdownH1 yellow
" hi! link markdownH2 {blue}
" hi! link markdownH3 {green}
" hi! link markdownH4 {pink}
" hi! link markdownH5 {orange}
" nnoremap <leader>( :AirlineTheme random<CR>

" airline themes that were noteworthy
" angr
" brogrammer
" kilor
" base16_tube
" base16_tube
" base16_railscasts









