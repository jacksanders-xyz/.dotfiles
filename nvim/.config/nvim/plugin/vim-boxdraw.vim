" -------- Keyboard mappings --------
" Box drawing
vnoremap +o :<C-u>call boxdraw#Draw("+o", [])<CR>
vnoremap +O :<C-u>call boxdraw#DrawWithLabel("+O", [])<CR> vnoremap +[O :<C-u>call boxdraw#DrawWithLabel("+[O", [])<CR>
vnoremap +]O :<C-u>call boxdraw#DrawWithLabel("+]O", [])<CR>
vnoremap +{[O :<C-u>call boxdraw#DrawWithLabel("+{[O", [])<CR>
vnoremap +{]O :<C-u>call boxdraw#DrawWithLabel("+{]O", [])<CR>
vnoremap +}[O :<C-u>call boxdraw#DrawWithLabel("+}[O", [])<CR>
vnoremap +}]O :<C-u>call boxdraw#DrawWithLabel("+}]O", [])<CR>

" Labeling
vnoremap +c :<C-u>call boxdraw#DrawWithLabel("+c", [])<CR>
vnoremap +{c :<C-u>call boxdraw#DrawWithLabel("+{c", [])<CR>
vnoremap +}c :<C-u>call boxdraw#DrawWithLabel("+}c", [])<CR>
vnoremap +{[c :<C-u>call boxdraw#DrawWithLabel("+{[c", [])<CR>
vnoremap +{]c :<C-u>call boxdraw#DrawWithLabel("+{]c", [])<CR>
vnoremap +}[c :<C-u>call boxdraw#DrawWithLabel("+}[c", [])<CR>
vnoremap +}]c :<C-u>call boxdraw#DrawWithLabel("+}]c", [])<CR>
vnoremap +[c :<C-u>call boxdraw#DrawWithLabel("+[c", [])<CR>
vnoremap +]c :<C-u>call boxdraw#DrawWithLabel("+]c", [])<CR>
vnoremap +D :<C-u>echo boxdraw#debug()<CR>

" Line drawing
vnoremap +> :<C-u>call boxdraw#Draw("+>", [])<CR>
vnoremap +< :<C-u>call boxdraw#Draw("+<", [])<CR>
vnoremap +v :<C-u>call boxdraw#Draw("+v", [])<CR>
vnoremap +V :<C-u>call boxdraw#Draw("+v", [])<CR>
vnoremap +^ :<C-u>call boxdraw#Draw("+^", [])<CR>

vnoremap ++> :<C-u>call boxdraw#Draw("++>", [])<CR>
vnoremap ++< :<C-u>call boxdraw#Draw("++<", [])<CR>
vnoremap ++v :<C-u>call boxdraw#Draw("++v", [])<CR>
vnoremap ++V :<C-u>call boxdraw#Draw("++v", [])<CR>
vnoremap ++^ :<C-u>call boxdraw#Draw("++^", [])<CR>

vnoremap +- :<C-u>call boxdraw#Draw("+-", [])<CR>
vnoremap +_ :<C-u>call boxdraw#Draw("+_", [])<CR>
vnoremap +\| :<C-u>call boxdraw#Draw("+\|", [])<CR>

" Selection
vnoremap ao :<C-u>call boxdraw#Select("ao")<CR>
vnoremap io :<C-u>call boxdraw#Select("io")<CR>

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
fun! IncrementSelection()
  norm! {jmt}kmb't
  :execute "normal! \<c-v>'b$\<esc>"
endfun
fun! DrawABox()
  call boxdraw#Draw("+o", [])
endfun
fun! Prepatory()
  norm! g'<
  let @s = col('.') - 1
  :if @s > 0
  norm! gv=
  :endif
endfun
fun! BoxDrawParagraph()
  let @a = ''
  call Prepatory()
  norm! vap'>$:
  call IncrementSelection()
  norm! gv"ay'tyyp'byykp
  norm! 'tV'b>.'t
  :execute "normal! \<c-v>'bI \<esc>"
  norm! V'b$:
  call GetRightmostCol()
  :set ve=block
  norm! 't0
  :execute "normal! \<c-v>'b0@ll:\<c-u>call DrawABox()\<cr>"
  :set ve=onemore
  norm! 'tjlmi'bklme`i
  :execute "normal! \<c-v>`et|\<esc>"
  norm! gv"aP
  :execute "normal! \<c-v>`eI  \<esc>"
  norm! gvlyf|
  :if @s == 0
  :execute "normal! \<c-v>PA|\<esc>"
  :else
  :execute "normal! \<c-v>PA|\<esc>'tV'b:m'<-2\<cr>'t\<c-v>'b@sI "
  :endif
  :delmarks!
  let @a = ''
  let @s = ''
  let @l = ''
endfun
vnoremap <leader>bp :<C-u>call BoxDrawParagraph()<CR>
vnoremap <leader>bb :<C-u>call Prepatory()<CR>
vnoremap <leader>bf :<C-u>call GetRightmostCol()<CR>

" hello I am
" gonna check if boxes are
" working in this context


                      " hello this is a little paragraph that i want to
                      " draw a box around. This paragraph happens to be
                      " staggared around multiple lines, this is
                      " different than the paragraph's that will be
                      " on one line, which will be hard, but i will do.

" norm! g'<ms
"
" vnoremap K :m '<-2<CR>gv=gv
"
" hello this is a little paragraph that i want to
" draw a box around. This paragraph happens to be
" staggared around multiple lines, this is
" different than the paragraph's that will be
" on one line, which will be hard, but i will do.



" - the boxes will align when indentined... you can do this by pasting the
"   white space in that was the difference from the inital column offset
" - the boxes will seperate themselves from blocks of words
" ALSO for some reason, (when you want to move to block to the place you put
" the period, selecting and then J moves it downward to the correct indent???
" idk
" https://vim.fandom.com/wiki/Replace_a_visual-block_of_text_with_another_such_block
