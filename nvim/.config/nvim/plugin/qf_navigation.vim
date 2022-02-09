nnoremap <C-Left> :call AfPPAlternatePluthPluth()<CR>
nnoremap <C-Up> :call AfPPAlternate()<CR>
inoremap <C-Left> <esc>:call AfPPAlternatePluthPluth()<CR>
inoremap <C-Up> <esc>:call AfPPAlternate()<CR>
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz

nnoremap <leader>J :lnext<CR>zz
nnoremap <leader>K :lprev<CR>zz

nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>

let g:jacks_qf_l = 0
let g:jacks_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:jacks_qf_g == 1
            let g:jacks_qf_g = 0
            cclose
        else
            let g:jacks_qf_g = 1
            copen
        end
    else
        if g:jacks_qf_l == 1
            let g:jacks_qf_l = 0
            lclose
        else
            let g:jacks_qf_l = 1
            lopen
        end
    endif
endfun
i
