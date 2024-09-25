return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "AckslD/nvim-neoclip.lua",
            "jvgrootveld/telescope-zoxide",
            "nvim-telescope/telescope-file-browser.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            local telescope = require('telescope')
            require('telescope').setup({
                defaults = {
                    file_sorter = require("telescope.sorters").get_fzy_sorter,
                    prompt_prefix = " > ",
                    color_devicons = true,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    Grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    mappings = {
                        i = {
                            -- ["<C-x>"] = false,
                            ["<C-q>"] = actions.send_to_qflist,
                        },
                    },
                },
                extensions = {
                    fzf = {
                      fuzzy = true,
                      override_generic_sorter = true,
                      override_file_sorter = true,
                      case_mode = "smart_case",
                    },
                    file_browser = {
                        path = "%:p:h",
                        dir_icon = ''
                    },
                    docker = {
                        binary = "docker",
                    }
                },
            })
            local builtin = require('telescope.builtin')

            -- BASIC TELE
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({
                    find_command = { 'rg', '--hidden', '--files', '-g', '!node_modules/**', '-g', '!.git/**' }
                })
            end, { noremap = true, silent = true })

            vim.keymap.set('n', '<leader>fg', function()
                builtin.live_grep({
                    vimgrep_arguments = {
                        'rg', '--hidden', '--color=never', '--no-heading', '--with-filename',
                        '--line-number', '--column', '--smart-case', '-u',
                    },
                    file_ignore_patterns = { 'node_modules', '.git' }
                })
            end, { noremap = true, silent = true })

            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})

            -- QFIX STUFF
            vim.keymap.set('n', '<leader>fps', function()
                builtin.grep_string({
                    search = vim.fn.input("--Grep For > ") })
            end)
            vim.keymap.set('n', '<leader>fpw', function()
                local word = vim.fn.expand("<cWORD>")
                builtin.grep_string({ search = word })
            end)

            -- CUSTOM PICKERS
            vim.keymap.set('n', '<leader>fn', function()
                builtin.find_files({
                    prompt_title = "< Jack's Brain >",
                    file_ignore_patterns = {
                        "^IMAGE_POOL/",
                        "%.git",
                        "%.DS_Store",
                        "^jacks_brain/MUSIC"
                    },
                    cwd = '~/VimWiki/',
                    hidden = true,
                })
            end)

            vim.keymap.set('n', '<leader>fs', function()
                builtin.live_grep({
                    prompt_title = "< Grep Jack's Brain >",
                    file_ignore_patterns = {
                        "^IMAGE_POOL/",
                        "%.git",
                        "%.DS_Store",
                        "^jacks_brain/MUSIC"
                    },
                    cwd = '~/VimWiki/',
                    hidden = true,
                })
            end)

            vim.keymap.set('n', '<leader>fdf', function()
                builtin.find_files(
                    {
                        prompt_title = "< .dotfiles >",
                        file_ignore_patterns = {
                            "%.git",
                            "%.DS_Store",
                        },
                        hidden = true,
                        cwd = '~/.dotfiles',
                    }
                )
            end)

            vim.keymap.set('n', '<leader>fdg', function()
                builtin.live_grep(
                    {
                        prompt_title = "< Grep .dotfiles >",
                        file_ignore_patterns = {
                            "%.git",
                            "%.DS_Store",
                        },
                        cwd = '~/.config/nvim',
                        hidden = true,
                    })
            end)

            pcall(require("telescope").load_extension("fzf"))
            pcall(require'telescope'.load_extension('zoxide'))
            pcall(require('telescope').load_extension('neoclip'))

            -- NEOCLIP
            vim.keymap.set('n', '<leader>fc', function()
                telescope.extensions.neoclip.default{}
            end, { noremap = true, silent = true })

            -- ZOXIDE
            vim.keymap.set('n', '<leader>fz', function()
              telescope.extensions.zoxide.list{}
            end, { noremap = true, silent = true })

            -- FILE BROWSER
            vim.keymap.set('n', '<leader>fl', function()
              telescope.extensions.file_browser.file_browser{}
            end, { noremap = true, silent = true })

            -- GIT
            vim.keymap.set('n',"<leader>gc", function()
                builtin.git_branches({
                    attach_mappings = function(_, map)
                        map("i", "<c-d>", actions.git_delete_branch)
                        map("n", "<c-d>", actions.git_delete_branch)
                        return true
                    end})
            end)

            vim.keymap.set('n',"<leader>gC", function()
                builtin.git_commits()
            end)

            vim.keymap.set('n',"<leader>gBC", function()
                builtin.git_bcommits()
            end)

            vim.keymap.set('n',"<leader>gS", function()
                builtin.git_status()
            end)

            vim.keymap.set('n','<leader>fm', function()
                builtin.marks({'local'})
            end)

        end
    },
}
