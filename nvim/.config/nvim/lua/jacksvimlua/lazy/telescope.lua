return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            "jvgrootveld/telescope-zoxide",
        "nvim-telescope/telescope-file-browser.nvim",
            "axieax/urlview.nvim",
            "sshelll/telescope-gott.nvim",
            "benfowler/telescope-luasnip.nvim",
            "catgoose/telescope-helpgrep.nvim",
            "blacktrub/telescope-godoc.nvim",
        },
        config = function()
            local actions = require("telescope.actions")
            local telescope = require('telescope')
            local ts      = require("telescope")
            local builtin = require("telescope.builtin")
            local themes  = require("telescope.themes")
            local ts_trbl = require("trouble.sources.telescope")

            require('telescope').setup({
                defaults = {
                    file_sorter = require("telescope.sorters").get_fzy_sorter,
                    prompt_prefix = " > ",
                    color_devicons = true,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    Grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    path_display = { "truncate" },
                    layout_strategy = "vertical",
                    sorting_strategy = "ascending",
                    layout_config = {
                        vertical = {
                            preview_cutoff = 0,
                            prompt_position = "top",
                            preview_height = 0.62,
                            width = 0.58,
                            height = 100,
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-q>"] = actions.send_to_qflist,
                        }
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
                    },
                },
            })

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

            vim.keymap.set('n', '<c-g>', function()
                builtin.buffers({
                    attach_mappings = function(_, map)
                        map("i", "<c-d>", actions.delete_buffer)
                        map("n", "<c-d>", actions.delete_buffer)
                        return true
                    end
                })
            end)

            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fH', '<cmd>Telescope helpgrep<cr>', { noremap = true, silent = true })

            ---------------------------------------------------------------------------
            --  traverser start
            ---------------------------------------------------------------------------
            local builtin       = require("telescope.builtin")
            local actions       = require("telescope.actions")
            local action_state  = require("telescope.actions.state")
            local api, fn       = vim.api, vim.fn

            -- right-hand split that never overlaps Trouble
            local function split_opts()
                local win   = api.nvim_get_current_win()
                local ww    = api.nvim_win_get_width(win)
                local wh    = api.nvim_win_get_height(win)
                local ui_w, ui_h = vim.o.columns, vim.o.lines
                local gap_left, border_w, border_h = 0, 1, 1

                return {
                    border          = true,
                    layout_strategy = "vertical",
                    previewer       = false,
                    layout_config   = {
                        anchor          = "NE",
                        width           = (ww - gap_left - border_w) / ui_w,
                        height          = (wh               + border_h) / ui_h,
                        prompt_position = "bottom",
                        preview_cutoff  = 0,
                    },
                }
            end

            --------------------------------------------------------------------
            -- Peek action: jump in *saved* code window, refresh Trouble, stay in picker
            --------------------------------------------------------------------
            local function make_peek(code_win_id)
                return function(prompt_bufnr)
                    local entry = action_state.get_selected_entry(); if not entry then return end

                    -- resolve LSP location → file / line / col
                    local loc   = entry.value or entry
                    local file  = loc.filename or (loc.uri and vim.uri_to_fname(loc.uri)); if not file then return end
                    local line  = (loc.lnum or (loc.range and loc.range.start.line) or 0) + 1
                    local col   =  loc.col  or (loc.range and loc.range.start.character) or 0

                    -- validate the saved window; if it vanished, abort
                    if not (code_win_id and api.nvim_win_is_valid(code_win_id)) then return end

                    -- load buffer & jump (focus stays in Telescope via win_call)
                    local bufnr = fn.bufadd(file); fn.bufload(bufnr)
                    api.nvim_win_call(code_win_id, function()
                        if api.nvim_win_get_buf(code_win_id) ~= bufnr then
                            api.nvim_win_set_buf(code_win_id, bufnr)
                        end
                        api.nvim_win_set_cursor(code_win_id, { line, col })
                    end)

                    -- tell Trouble-symbols to refresh
                    local ok, trouble = pcall(require, "trouble")
                    if ok and trouble.refresh then trouble.refresh({ mode = "symbols" }) end
                end
            end

            -- helper that spawns a symbol picker with <C-e> bound to peek --------------
            local function symbols_picker(kind) -- "buf" | "ws"
                local code_win_id = vim.api.nvim_get_current_win()
                local picker_fn   = (kind == "ws")
                and function(opts)
                    builtin.lsp_dynamic_workspace_symbols(vim.tbl_extend("force", { default_text = "." }, opts))
                end
                or builtin.lsp_document_symbols

                picker_fn(vim.tbl_extend("force", split_opts(), {
                    attach_mappings = function(_, map)
                        map({ "i", "n" }, "<C-e>", make_peek(code_win_id))
                        return true
                    end,
                }))
            end

            -- key-maps -----------------------------------------------------------------
            vim.keymap.set("n", "<C-p>",     function() symbols_picker("buf") end,
                { desc = "Buffer symbols (peek with <C-e>)",     noremap = true, silent = true })

            vim.keymap.set("n", "<leader>O", function() symbols_picker("ws")  end,
                { desc = "Workspace symbols (peek with <C-e>)", noremap = true, silent = true })

            ---------------------------------------------------------------------------
            --  traverser end
            ---------------------------------------------------------------------------

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
            pcall(require("telescope").load_extension("helpgrep"))
            pcall(require('telescope').load_extension('luasnip'))
            pcall(require'telescope'.load_extension('zoxide'))
            pcall(require("telescope").load_extension("godoc"))

            -- GOTEST
            pcall(require('telescope').load_extension('gott'))

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

            vim.keymap.set('n', '<leader>FG',  '<cmd>Telescope godoc<cr>', { noremap = true, silent = true })
        end
    },
    {
        "axieax/urlview.nvim",
        config = function()
            require("urlview").setup({})
            vim.keymap.set('n', '<leader>fu', '<cmd>UrlView buffer picker=telescope<cr>', { noremap = true, silent = true })
        end
    },
    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup({
                keys = {
                    telescope = {
                        i = {
                            select = '<c-y>',
                            paste = '<cr>',
                        }
                    }
                }

            })
            vim.keymap.set('n', '<leader>fc', '<cmd>Telescope neoclip<cr>')
        end
    }
}
