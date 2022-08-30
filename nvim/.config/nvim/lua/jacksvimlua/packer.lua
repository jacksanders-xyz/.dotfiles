-- This file can be loaded by calling `lua require('plugins')` from your init.lua
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- T-POPE
    use 'tpope/vim-vinegar'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'
    use 'tpope/vim-rhubarb'

    -- STARTIFY
     use 'mhinz/vim-startify'

    -- TASKWARRIOR
    use 'xarthurx/taskwarrior.vim'

    -- FIND FILES / TELESCOPE
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'ThePrimeagen/harpoon'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    -- TELESCOPE EXTENSIONS
    use 'dhruvmanila/telescope-bookmarks.nvim'
    use 'ThePrimeagen/git-worktree.nvim'
    use 'AckslD/nvim-neoclip.lua'
    use 'jvgrootveld/telescope-zoxide'
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- COLORS
    use 'altercation/vim-colors-solarized'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
    use 'tjdevries/colorbuddy.vim'
    use 'tjdevries/gruvbuddy.nvim'

    -- COMPLETION
    use('hrsh7th/nvim-cmp')
    use('tzachar/cmp-tabnine', { run = './install.sh', requires = 'hrsh7th/nvim-cmp' })
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('nvim-lua/lsp_extensions.nvim')
    use('quangnguyen30192/cmp-nvim-ultisnips')
    use('onsails/lspkind-nvim')
    use('glepnir/lspsaga.nvim')
    -- use('simrat39/symbols-outline.nvim')

    -- ICONS
    use 'kyazdani42/nvim-web-devicons'
    -- use { 'yamatsum/nvim-nonicons', requires = {'kyazdani42/nvim-web-devicons'} }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'

    -- VIMSPECTOR
    use 'puremourning/vimspector'

    -- TREESITTER
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'

    -- PRODUCTIVITY/VISUAL
    use 'sirVer/ultisnips'
    use 'szw/vim-maximizer'
    use 'reedes/vim-pencil'
    use 'junegunn/goyo.vim'
    use 'airblade/vim-gitgutter'

    -- VIM WIKI
    use 'vimwiki/vimwiki'
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' }

    -- LANGS
    use 'mrk21/yaml-vim'
    use 'osyo-manga/vim-over'
    use { 'darrikonn/vim-gofmt', run = ':GoUpdateBinaries' }
    -- use {'stamblerre/gocode', rtp = 'vim', run = '~/.vim/plugged/gocode/vim/symlink.sh' }}

    -- VIM-BOXDRAW
    use 'gyim/vim-boxdraw'

     -- LIB-MODAL
    use 'Iron-E/nvim-libmodal'

    -- COFFEE SCRIPT UNTIL TREE SITTER SUPPORTS
    use 'kchmck/vim-coffee-script'

    -- DOCKER CONTAINERS
    use 'dgrbrady/nvim-docker'
    use 'MunifTanjim/nui.nvim'

    -- OTHER
    use 'thinca/vim-qfreplace'
    use 'kshenoy/vim-signature'
    use 'editorconfig/editorconfig-vim'
    use 'posva/vim-vue'
    use { 'kevinhwang91/rnvimr', run = 'make sync'}
end)
