"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

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

" COLORS
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'

"LSP
Plug 'neovim/nvim-lspconfig'

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

" FLOATTERM
Plug 'voldikss/vim-floaterm'

" LANGS
Plug 'mhartington/nvim-typescript', {'for': ['typescript', 'tsx'], 'do': './install.sh' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mrk21/yaml-vim'
Plug 'osyo-manga/vim-over'

" VIM-BOXDRAW
Plug 'gyim/vim-boxdraw'

" SUPERCOLLIDER
Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }

" LIB-MODAL
Plug 'Iron-E/nvim-libmodal'

" OTHER
Plug 'thinca/vim-qfreplace'
Plug 'kshenoy/vim-signature'
Plug 'editorconfig/editorconfig-vim'
Plug 'posva/vim-vue'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
call plug#end()


" LEADER
let mapleader=" "

" GENERAL CONFIG
inoremap jj <ESC>
inoremap jk <ESC>
syntax enable
command E Ex " Disambiguates E
filetype plugin on
filetype indent on

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

" TREESITTER
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }}

" TYPESCRIPT
autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
au FileType go nnoremap <leader>got :GoTest -short<cr>
au Filetype go nnoremap <leader>goa <Plug>(go-alternate-edit)
au FileType go nnoremap <leader>goc :GoCoverageToggle -short<cr>
au FileType go nnoremap <leader>god <Plug>(go-def)

" ALE
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_lint_on_save = 1
let g:ale_fixers = ['eslint']
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:airline#extensions#ale#enabled = 1
autocmd BufWritePost *.js ALEFix


" DEOPLETE
let g:python3_host_prog = '/usr/local/bin/python3'
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'~/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" let g:python_host_prog = '/usr/bin/python'

" ACK.VIM
let g:ackprg = 'ag --nogroup --nocolor --column'

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

" FUGITIVE
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Git status<CR> " Views status, use `-` and `p` to add/remove files
nnoremap <leader>gd :Git diff<CR>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <leader>gg :Git commit -v -q %:p<CR> " Commits current file
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gm :Git merge<CR>

" MAXIMIZER FOR THE DEBUGGER
nnoremap <leader>, :MaximizerToggle!<CR>

" VIMSPECTOR DUBUGGER
" JUMP AROUND
nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
nnoremap <leader>dX :call vimspector#ClearBreakpoints()><CR>

fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
" nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>


nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
nmap <leader>dk <Plug>VimspectorStepOut
nmap <leader>d_ <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>drc <Plug>VimspectorRunToCursor
nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint

nnoremap <leader>d? :call AddToWatch()<CR>
func! AddToWatch()
  let word = expand("<cexpr>")
  call vimspector#AddWatch(word)
endfunction

" TOGGLE FOR DEBUG SERVERS/OFF FOR LOCAL
" OFF IS LOCAL, ON IS GLOBAL
" let g:vimspector_base_dir = expand('$HOME/.config/vimspector-config')

"BUFFER MANAGEMENT
nnoremap <leader>x :bd<CR> " Delete current buffer
nnoremap <leader>X :bd!<CR> " Delete current buffer
nnoremap <leader>n :bn!<CR> " Next buffer
nnoremap <leader>N :bN!<CR> " Previous buffer
nnoremap <leader>tn :enew<CR> " Make a new empty buffer
nnoremap <Tab> :b#<CR> " Tab between buffers

" GOTO todo LIST
nnoremap <leader>td :enew<CR>'T

" ESLINT
nnoremap <leader>e :new<Bar>0r!npm run lint<CR> " Run eslint in vue

" SPLIT NAVIGATION
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NEWLINE GENERATION
nmap <C-o> O<Esc>
nmap <CR> o<Esc>

nnoremap <leader>. @: " Repeat last ex command

" YANK/PUT FROM/TO CLIPBOARD
vnoremap <leader>y "*y
map<leader>p "*P
inoremap<c-p> <ESC>"*Pi

" MAKE Y BEHAVE LIKE ALL THE OTHER CAPITAL LETTERS
nnoremap Y y$

" SPELLCHECK TOGGLE IS <F4>
:map <F4> :setlocal spell! spelllang=en_us<CR>

" MOVING TEXT AROUND
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-k> <esc>:m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap ]e I<CR><ESC>==
