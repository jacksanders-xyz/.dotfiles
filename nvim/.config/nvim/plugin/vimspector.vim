" VIMSPECTOR DUBUGGER

" FIRE UP
nnoremap <leader>dd :call vimspector#Launch()<CR>

" SHUT DOWN
nnoremap <leader>de :call vimspector#Reset()<CR>

" PICK A WINDOW (ONCE MAXIMIZED, TO TURN IT OFF JUST UNMAXIMIZE: <leader>,
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>


" BREAKPOINTS
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()><CR>

" MOVEMENT
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut

" RUN THE CODE
nnoremap <leader>d<space> :call vimspector#Continue()<CR>
nmap <leader>drc <Plug>VimspectorRunToCursor

" RESET CODE
nmap <leader>d_ <Plug>VimspectorRestart

" PICK A VARIABLE TO WATCH
nnoremap <leader>d? :call AddToWatch()<CR>
func! AddToWatch()
  let word = expand("<cexpr>")
  call vimspector#AddWatch(word)
endfunction

" TOGGLE FOR DEBUG SERVERS/OFF FOR LOCAL
" OFF IS LOCAL, ON IS GLOBAL
" let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')
