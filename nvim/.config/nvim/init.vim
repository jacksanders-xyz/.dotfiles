"     ____            __          _
"    /   _/___   ___ / / __    __(_)___ ___
"     / // __ \/  - / /_/ / | / / / __ `__ \
" __ / // / / / /__/ /\ \ | |/ / / / / / / /
"/___/_/ /_/_/\___/_/_/_(_)___/_/_/ /_/ /_/

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" T-POPE
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rhubarb'
" Plug 'tpope/vim-unimpaired'

" STARTIFY
Plug 'mhinz/vim-startify'

" TASKWARRIOR
Plug 'xarthurx/taskwarrior.vim'
Plug 'tools-life/taskwiki'

" FIND FILES
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'ThePrimeagen/git-worktree.nvim'

" COLORS
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

" VIMSPECTOR
Plug 'puremourning/vimspector'

" TREESITTER
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" DEOPLETE
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }

" PRODUCTIVITY/VISUAL
Plug 'sirVer/ultisnips'
Plug 'szw/vim-maximizer'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'airblade/vim-gitgutter'

" VIM WIKI
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" FLOATTERM
Plug 'voldikss/vim-floaterm'

" LANGS
Plug 'mrk21/yaml-vim'
Plug 'osyo-manga/vim-over'

" VIM-BOXDRAW
Plug 'gyim/vim-boxdraw'

" LIB-MODAL
Plug 'Iron-E/nvim-libmodal'

" COFFEE SCRIPT UNTIL TREE SITTER SUPPORTS
Plug 'kchmck/vim-coffee-script'

" OTHER
Plug 'thinca/vim-qfreplace'
Plug 'kshenoy/vim-signature'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
call plug#end()

" ADDING LOCAL MODULES
let &runtimepath.=',' . expand("$HOME") . '/personal/wiki-Flash'

" LEADER
let mapleader=" "

" GENERAL CONFIG
syntax enable
command E Ex " Disambiguates E
filetype plugin on
filetype indent on

" :W now also writes, same as :w
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>

" TRIM WHITESPACE AUTO COMMAND
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup CLEANLINESS
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" VIM-YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'

" STATUS LINES
set statusline+=%#warningmsg#
set statusline+=%*

" FIND AND REPLACE
function! VisualFindAndReplace()
    :OverCommandLine%s/
endfunction
function! VisualFindAndReplaceWithSelection() range
    :'<,'>OverCommandLine s/
endfunction
nnoremap <leader>fr :call VisualFindAndReplace()<CR>
xnoremap <leader>fr :call VisualFindAndReplaceWithSelection()<CR>

" GOYO
let g:goyo_width=90
nnoremap <leader>m :Goyo<cr>

" MAXIMIZER FOR VIMSPECTOR
nnoremap <leader>, :MaximizerToggle!<CR>

" BUFFER MANAGEMENT
nnoremap <silent><leader>x :bd<CR> " Delete current buffer
nnoremap <silent><leader>X :bd!<CR> " Delete current buffer
nnoremap <silent><leader>n :bn!<CR> " Next buffer
nnoremap <silent><leader>N :bN!<CR> " Previous buffer
nnoremap <silent><leader>tn :enew<CR> " Make a new empty buffer
nnoremap <silent><Tab> :b#<CR> " Tab between buffers

" GOTO todo LIST
nnoremap <leader>td :enew<CR>'T

" ESLINT
nnoremap <leader>e :new<Bar>0r!npm run lint<CR> " Run eslint in vue

" NEWLINE GENERATION
nmap <C-o> O<Esc>
" nmap <CR> o<Esc>

nnoremap <leader>. @: " Repeat last ex command

" YANK/PUT FROM/TO CLIPBOARD
vnoremap <leader>y "*y
map<leader>p "*P
inoremap<c-p> <ESC>"*Pi

" MAKE Y BEHAVE LIKE ALL THE OTHER CAPITAL LETTERS
nnoremap Y y$

" SPELLCHECK TOGGLE IS <F4>
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" MOVING TEXT AROUND
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap ]e I<CR><ESC>==

" DELETE ALL MARKS
nnoremap <C-\> :delmarks!<CR>

" NERDTREE
nnoremap <leader>iv :Ex<CR>
nnoremap <leader>is <C-w><C-v>:Ex<CR>
