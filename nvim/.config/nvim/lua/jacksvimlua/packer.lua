-- This file can be loaded by calling `lua require('plugins')` from your init.lua
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- T-POPE
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'

    -- GIT
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    -- use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- NETRW STUFF
    use 'stevearc/oil.nvim'

    -- STARTIFY
    use 'mhinz/vim-startify'

    -- FIND FILES / TELESCOPE
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'ThePrimeagen/harpoon'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'

    -- TELESCOPE EXTENSIONS
    use 'dhruvmanila/browser-bookmarks.nvim'
    use 'ThePrimeagen/git-worktree.nvim'
    use 'AckslD/nvim-neoclip.lua'
    use 'jvgrootveld/telescope-zoxide'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'lpoto/telescope-docker.nvim'

    -- STATUSLINE AND BAR
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    -- COLORS
    -- use 'folke/tokyonight.nvim'
    use "rebelot/kanagawa.nvim"

    -- COMPLETION
    use('hrsh7th/nvim-cmp')
    use('tzachar/cmp-tabnine', { run = './install.sh', requires = 'hrsh7th/nvim-cmp' })
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('nvim-lua/lsp_extensions.nvim')
    use('quangnguyen30192/cmp-nvim-ultisnips')
    use('onsails/lspkind-nvim')
    use('glepnir/lspsaga.nvim')
    -- use('simrat39/symbols-outline.nvim')

    -- ICONS
    use 'kyazdani42/nvim-web-devicons'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- UNDOTREE
    use 'mbbill/undotree'

    -- DAP
    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-neotest/nvim-nio'

    -- TREESITTER
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/playground'
    use 'nvim-treesitter/nvim-treesitter-context';

    -- USES TREESITTER
    use 'Wansmer/treesj';

    -- COPILOT
    use 'github/copilot.vim';

    -- TROUBLE
    use 'folke/trouble.nvim';

    -- PRODUCTIVITY/VISUAL
    use 'sirVer/ultisnips'
    use 'szw/vim-maximizer'
    use 'reedes/vim-pencil'
    use 'airblade/vim-gitgutter'
    use {
        'loqusion/true-zen.nvim',
    }

    -- VIM WIKI
    use 'vimwiki/vimwiki'

    -- SLIDESHOW
    -- use'Olical/kkslider'

    -- MARKDOWNPREVIEW
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })

    -- LANGS
    use 'mrk21/yaml-vim'
    use 'osyo-manga/vim-over'
    use { 'darrikonn/vim-gofmt', run = ':GoUpdateBinaries' }

    -- VIM-BOXDRAW
    use 'gyim/vim-boxdraw'

     -- LIB-MODAL
    use 'Iron-E/nvim-libmodal'

    -- COFFEE SCRIPT UNTIL TREE SITTER SUPPORTS
    use 'kchmck/vim-coffee-script'
    use 'axieax/urlview.nvim'

    -- ORGMODE
    use {'nvim-orgmode/orgmode' }

    -- MARKS
    use 'chentoast/marks.nvim'

    -- JUPYTER
    use { "kiyoon/jupynium.nvim", run = "pip3 install --user ." }
    -- use { "kiyoon/jupynium.nvim", run = "conda run --no-capture-output -n jupynium pip install ." }
    use { "rcarriga/nvim-notify" }   -- optional
    use { "stevearc/dressing.nvim" } -- optional, UI for :JupyniumKernelSelect

end)
