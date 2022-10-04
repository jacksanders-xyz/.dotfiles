" -------- Keyboard mappings --------
" Box drawing
" finds you the furthest column in a block! and sets it to g:rightmostCol:
function! GetRightmostCol()
   :let @l=''
   let start=line("'<")
   let end=line("'>")
   let line=start
   let len=len(getline(line))
   while line<=end
      let len=len<len(getline(line))?len(getline(line)):len
      let line+=1
   endwhile
   :let @l=len
endfunction

" fun! IncrementSelection()
"   norm! {jmt}kmb't
"   :execute "normal! \<c-v>'b$\<esc>"
" endfun
" fun! DrawABox()
"   call boxdraw#Draw("+o", [])
" endfun
" fun! Prepatory()
"   norm! g'<
"   let @s = col('.') - 1
"   :if @s > 0
"   norm! gv=
"   :endif
" endfun
" fun! BoxDrawParagraph()
"   let @a = ''
"   call Prepatory()
"   norm! '>$:
"   call IncrementSelection()
"   norm! gv"ay'tyyp'byykp
"   norm! 'tV'b>.'t
"   :execute "normal! \<c-v>'bI \<esc>"
"   norm! V'b$:
"   call GetRightmostCol()
"   :set ve=block
"   norm! 't0
"   :execute "normal! \<c-v>'b0@ll:\<c-u>call DrawABox()\<cr>"
"   :set ve=onemore
"   norm! 'tjlmi'bklme`i
"   :execute "normal! \<c-v>`et|\<esc>"
"   norm! gv"aP
"   :execute "normal! \<c-v>`eI  \<esc>"
"   norm! gvlyf|
"   :if @s == 0
"   :execute "normal! \<c-v>PA|\<esc>"
"   :else
"   :execute "normal! \<c-v>PA|\<esc>'tV'b:m'<-2\<cr>'t\<c-v>'b@sI "
"   :endif
"   :delmarks!
"   let @a = ''
"   let @s = ''
"   let @l = ''
" endfun

" When only one on line
fun! BoxDrawParagraph()
    :set ve=all
    :execute "norm! gv"
    :call GetRightmostCol()
    :execute "normal gv\"aymfyypg'>yypmg\<c-v>'fI \<esc>\<c-v>'g@ll+o\<c-v>`fio\"aP"
    :set ve=onemore
    :set nohlsearch
    :set incsearch
    :delmarks f g
endfun

" " Next to another on the same line, must be delimited with ]ov
" fun! BoxDrawParagraphTwin()
"     :set ve=block
"     :execute "normal gv\<c-c>a \<esc>meg'<mfgv\"ay'fyyp'eyyp\<c-v>'fI \<esc>mfmf`eja \<esc>me`f\<c-v>`e+o\<c-v>`fio\"aP"
"     :set ve=onemore
"     :set incsearch
"     :set nohlsearch
"     :delmarks f g
" endfun

" Next to another on the same line, must be delimited with ]ov
fun! BoxDrawParagraphTwin()
    :set ve=all
    :execute "normal gv\<c-c>mpg'<mogv\"ay\<c-v>'pI \<esc>kmb`pjllme\<c-v>`b+o`o\<c-v>`pio\"aP"
    :set ve=onemore
    :set incsearch
    :set nohlsearch
    :delmarks b o p e
endfun

fun! DeleteBox()
    :execute "normal h\<c-v>lao:s/|//g\<CR>gv:s/+-.*+//g\<CR>"
endfun

fun! ToggleVE()
    :if &ve=='all'
        :set ve=onemore
    :elseif &ve=='onemore'
        :set ve=all
    :endif
endfun

nnoremap <silent>]ov :call ToggleVE()<CR>
vnoremap <leader>bp :<C-u>call BoxDrawParagraph()<CR>
vnoremap <leader>bt :<C-u>call BoxDrawParagraphTwin()<CR>
nnoremap <leader>bd :<C-u>call DeleteBox()<CR>
