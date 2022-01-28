" LIBMODAL SCORE MODE

fun! ScoreModeInit()
  if exists('g:score_was_triggered')
    lua re_entry_SL()
  endif
  if !exists('g:score_was_triggered')
    let g:score_was_triggered = 1
    lua require('mode-score')()
  endif
endfun

nnoremap <buffer> <silent><Leader><Tab> :call ScoreModeInit()<CR>
