" FLOATTERM
fun! FloattermSpecs()
  " map <leader>T :FloatermNew! cd %:p:h<CR>
  let g:floaterm_keymap_new = '<leader>T'
  let g:floaterm_keymap_toggle = '<leader>tt'
  let g:floaterm_keymap_prev   = '<leader>Tp'
  let g:floaterm_keymap_next   = '<leader>Tn'
  let g:floaterm_keymap_kill   = '<leader>Tk'
  hi FloatermBorder guifg=cyan
  hi FloatermNC guibg=gray
endfun
call FloattermSpecs()
