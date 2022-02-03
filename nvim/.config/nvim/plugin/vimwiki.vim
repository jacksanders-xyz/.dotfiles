" VIM WIKI
fun! ColorMarkdown()
  let g:vimwiki_ext2syntax= {'.md':'markdown','.markdown':'markdown','.mdown':'markdown' }
  let g:vimwiki_list = [
        \{'path': '~/VimWiki', 'syntax':'markdown', 'ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/RedHat', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/RedHat/DO180', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/PIPELINE', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/CLUSTER', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/AIandML', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/LANGS', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/WORKFLOW', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/jacks_brain/RANDOM', 'syntax':'markdown','ext':'.md' },
        \{'path':'~/VimWiki/work_content', 'syntax':'markdown','ext':'.md' }]

  let g:vimwiki_markdown_link_ext = 1
  let g:taskwiki_markup_syntax = 'markdown'
  let g:markdown_folding = 1
  :hi VimwikiHeader2 guifg=yellow
  :hi VimwikiHeader3 guifg=green
  :hi VimwikiHeader4 guifg=blue
  :hi VimwikiHeader5 guifg=violet
  :hi VimwikiHeader6 guifg=orange
endfun
call ColorMarkdown()

" MAKE A LINK FROM THE BUFFER
map <leader>wl "*PysiW)i[]<ESC>i

" MAKE A TABLE. THIS FUNCTION TAKES 2 NUMS, COLUMNS THEN (ROWS - 1)
map <leader>wT :VimwikiTable

fun! PrettyMyRH()
  :%s/^\[student@workstation \~]/\## [student@workstation \~]/e | %s/^>/\## >/e
endfun

" PRETTY UP ANY REDHAT LESSON IN VIMWIKI
nnoremap <leader>wpr :call PrettyMyRH()<CR>

fun! MakeOutputBox()
  norm! '<O```
  norm! o=>
  norm! '>o```
endfun

fun! MakeNotes()
  norm! '<O****
  norm! '>o****
  :exe 'normal!' "kI#### NOTE\r"
endfun
vnoremap <leader>wo :<C-u>call MakeOutputBox()<CR>
vnoremap <leader>wn :<C-u>call MakeNotes()<CR>

