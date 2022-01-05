let g:startify_bookmarks = [
      \ {'c': '~/.config/nvim/init.vim'},
      \ {'z':'~/.zshrc'},
      \ {'t':'~/VimWiki/ToDo.md'},
      \ {'p':'~/.vim/plugged/'},
      \ ]


" :h startify-colors
highlight StartifyFile  guifg=yellow
highlight StartifySection  guifg=blue

let g:startify_enable_special = 0
let g:startify_lists = [
      \ { 'header': ['   Bookmarks'],       'type': 'bookmarks' },
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
      \ ]

      " \ { 'type': function('s:tasks'), 'header': ['   TASKS'], },
      " move this to the top


" function! s:tasks()
" python3 << EOF
" import subprocess
" import json
" import vim
" tasks = json.loads(subprocess.check_output(['task', 'export']))
" tasks = list(filter(lambda x: x['status'] == 'pending', tasks))
" tasks = [{'line': task['description'],'cmd': ':TW ' + str(task['id'])} for task in tasks][:len(tasks)]
" vim.command("let tasklist = %s"% tasks)
" EOF
"     return tasklist
" endfunction
