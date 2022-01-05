" LSP

" fun! LspLocationList()
"  lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
" endfun


" augroup jack_LSP
"   autocmd!
"   autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
" augroup END

