" FELINE

let g:FelineItermProf = 'BASE_PROF'

" TOGGLE STUFF IN THE STATUS BAR DEPENDING ON PROF
fun! SetStatusIconPref()
    :if g:FelineItermProf=='BASE_PROF'
        :let g:FelineItermProf = 'DICTATOR_PROF'
    :elseif g:FelineItermProf=='DICTATOR_PROF'
        :let g:FelineItermProf = 'BASE_PROF'
    :endif
    :so /Users/_jacksanders/.dotfiles/nvim/.config/nvim/lua/jacksvimlua/feline.lua
endfun

command! SetScoreModeStatusIcon call SetStatusIconPref()
