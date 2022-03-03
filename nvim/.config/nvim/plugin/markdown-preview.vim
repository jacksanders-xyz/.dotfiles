" TRIGGER THE PREVIEW
" fun! SetWorkspace()
"     :execute "normal! \<Plug>MarkdownPreview<CR>"
"     :! /Users/jsanders/split_browser_tab.sh
" endfun

fun! SetWorkspace()
endfun

fun! GrabWindowTab(param)
    let prep_string = ":! /Users/jsanders/tab_tracker.sh " . a:param
    " :echom prep_string
    :execute prep_string
endfun

let g:trackTabTrigger = 0

fun! TrackTabFunc()
    if g:trackTabTrigger == 0
        let g:trackTabTrigger=1
    else
        let g:trackTabTrigger = 0
    endif
endfun

" nmap <silent> <leader>MP :call SetWorkspace()<CR>
nmap <leader>MP <Plug>MarkdownPreview<CR>
nmap <leader>MS <Plug>MarkdownPreviewStop<CR>
nmap <C-g> <Plug>MarkdownPreviewToggle

nnoremap <leader>MT :call TrackTabFunc()<CR>

let g:mkdp_auto_close = 0
" let g:mkdp_page_title = '「${name}」'
let g:mkdp_page_title = '${name}'
" let g:mkdp_preview_options = {
    " \ 'disable_filename': 1
    " \ }

augroup trackTabs
    autocmd! BufEnter *.md
         \ if g:trackTabTrigger==1
             \ | execute 'autocmd! BufEnter *.md :call GrabWindowTab("usingLaTeX")'
        \ | endif

    " autocmd!
    " autocmd! BufEnter *.md :call GrabWindowTab()
augroup END
