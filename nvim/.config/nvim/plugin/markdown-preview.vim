" TRIGGER THE PREVIEW
" fun! SetWorkspace()
"     :execute "normal! \<Plug>MarkdownPreview<CR>"
"     :! /Users/jsanders/split_browser_tab.sh
" endfun

fun! GrabWindowTab(param)
"     :! /Users/jsanders/split_browser_tab.sh
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

augroup trackTabs

    autocmd BufEnter *.md
         \ if get(g:, 'trackTabTrigger') == 1
             \ | execute 'autocmd! BufEnter *.md :call GrabWindowTab("hello")'
        \ | endif
    " autocmd BufEnter *.md
    "     \ if get(g:, 'trackTabTrigger') == 1
    "         \ | execute 'autocmd! BufEnter *.md :call GrabWindowTab("hello")'
    "     \ | endif
    " autocmd!
    " autocmd! BufEnter *.md :call GrabWindowTab()
augroup END

" augroup LaunchShowContext | au!
"     autocmd BufEnter *
"         \ if get(w:, 'contextlist_open')
"             \ | execute 'autocmd! CursorHold <buffer> call ShowContext()'
"         \ | endif
" augroup end
