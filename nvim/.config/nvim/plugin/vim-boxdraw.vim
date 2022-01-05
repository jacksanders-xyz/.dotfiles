" -------- Keyboard mappings --------

" Box drawing
vnoremap +o :<C-u>call boxdraw#Draw("+o", [])<CR>
vnoremap +O :<C-u>call boxdraw#DrawWithLabel("+O", [])<CR>
vnoremap +[O :<C-u>call boxdraw#DrawWithLabel("+[O", [])<CR>
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

fun! BoxDrawSpecial(cmd, args, MyLabel)
	let theLabel = string(a:MyLabel)
	call boxdraw#Draw(a:cmd, [theLabel] + a:args)
endfun
