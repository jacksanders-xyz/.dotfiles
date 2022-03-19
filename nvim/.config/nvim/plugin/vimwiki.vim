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

fun! PrettyMyRH()
  :%s/^\[student@workstation \~]/\## [student@workstation \~]/e | %s/^>/\## >/e
endfun

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

fun! MakeFlash()
  :exe 'normal!' ":VimwikiFollowLink\r"
  :exe 'normal!' "f(aFLASH_DECK/"
endfun

" MAKE A LINK FROM THE BUFFER
map <leader>wl "*PysiW)i[]<ESC>i

" MAKE AN IMAGE, REQUIRES PATH TO IMAGE

" nnoremap <leader>wi i{{file:~/VimWiki/IMAGE_POOL/}}<ESC>F/a
nnoremap <leader>wI :lua require('jacksvimlua.ImagePathAutomator').ImagePathFind()<CR>

" MAKE AN clickable on github IMAGE, REQUIRES PATH TO IMAGE
nnoremap <leader>wg i{{file:~/VimWiki/IMAGE_POOL/}}<ESC>F/a

" OPEN THE IMAGES FOLDER TO PUSH AND PULL
nnoremap <leader>wG <C-w><C-v>:Ex ~/VimWiki/IMAGE_POOL/<CR>

" MAKE A TABLE. THIS FUNCTION TAKES 2 NUMS, COLUMNS THEN (ROWS - 1)
map <leader>wT :VimwikiTable col rows-1

vnoremap <leader>wo :<C-u>call MakeOutputBox()<CR>
vnoremap <leader>wn :<C-u>call MakeNotes()<CR>
nmap <leader>wf :<C-u>call MakeFlash()<CR>
nmap <C-f> :<C-u>call WikiFlash()<CR>

" PRETTY UP ANY REDHAT LESSON IN VIMWIKI
nnoremap <leader>wpr :call PrettyMyRH()<CR>
