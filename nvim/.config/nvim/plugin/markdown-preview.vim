" MARKDOWN PREVIEW
"
" TRIGGER THE PREVIEW
" fun! SetWorkspace()
"     :execute "normal! \<Plug>MarkdownPreview<CR>"
"     :! /Users/jsanders/split_browser_tab.sh
" endfun

" fun! SetWorkspaceAndReturnToIterm()
"     " :execute "MarkdownPreview"
"     let prep_string = ":! /Users/jsanders/iterm_back.sh"
"     :silent execute prep_string
" endfun

fun! GrabWindowTab()
    " let bufname = expand('%:r')
    let prep_string = ":! /Users/jsanders/tab_tracker.sh " . expand('%:t:r')
    :silent execute prep_string
endfun

" nmap <silent> <leader>MP :call SetWorkspace()<CR>
nmap <leader>MP <Plug>MarkdownPreview<CR>
nmap <leader>MS <Plug>MarkdownPreviewStop<CR>
nmap <C-g> <Plug>MarkdownPreviewToggle<CR>

" UNCOMMENT AUGROUP AT THE BOTTOM TO USE TAB TRACKING
nmap <leader>MT :let g:trackTabTrigger = !get(g:, 'trackTabTrigger', 1)<CR>
" nmap <C-g> <Plug>MarkdownPreviewToggle<CR>:call SetWorkspaceAndReturnToIterm()<CR>

nnoremap <silent><leader>/ :call GrabWindowTab()<CR>

let g:mkdp_auto_close = 0
" let g:mkdp_page_title = '「${name}」'
let g:mkdp_page_title = '${name}'
" let g:mkdp_preview_options = {
    " \ 'disable_filename': 1
    " \ }
" UNCOMMENT TO USE TAB TRACKING
" augroup trackTabs
"     " autocmd!
"     autocmd! BufEnter *.md if get(g:, 'trackTabTrigger', 1) | :call GrabWindowTab() | endif
" augroup END
