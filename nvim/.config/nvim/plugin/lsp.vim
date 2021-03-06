" LSP
" fun! LspLocationList()
   " vim.diagnostic.setloclist({open_loclist = false})
   " vim.diagnostic.setloclist()
" endfun


nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vrr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>vrn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>vca :lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>vfd :lua vim.diagnostic.open_float()<CR>
nnoremap <leader>vn :lua vim.lsp.diagnostic.goto_next()<CR>
" nnoremap <leader>vll :call LspLocationList()<CR>

augroup jack_LSP
    autocmd!
    autocmd! BufWrite,BufEnter,InsertLeave * :lua vim.diagnostic.setloclist({open = false})
    " autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
augroup END
