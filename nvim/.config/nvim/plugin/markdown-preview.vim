" TRIGGER THE PREVIEW
" fun! SetWorkspace()
"     :execute "normal! \<Plug>MarkdownPreview<CR>"
"     :! /Users/jsanders/split_browser_tab.sh
" endfun


" nmap <silent> <leader>MP :call SetWorkspace()<CR>
nmap <leader>MP <Plug>MarkdownPreview<CR>
nmap <leader>MS <Plug>MarkdownPreviewStop
nmap <C-m> <Plug>MarkdownPreviewToggle
