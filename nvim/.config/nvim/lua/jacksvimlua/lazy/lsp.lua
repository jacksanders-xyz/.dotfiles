return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        require("fidget").setup({})
        require("mason").setup()

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
            },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
-- YOUR LANGUAGE SERVERS:
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                      settings = {
                        Lua = {
                          runtime = {
                            version = 'LuaJIT',
                            -- Setup your lua path
                            path = vim.split(package.path, ';'),
                          },
                          diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'},
                          },
                          workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                          },
                          -- Do not send telemetry data containing a randomized but unique identifier
                          telemetry = {
                            enable = false,
                          },
                        },
                      },
}
                end,
            ["gopls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.gopls.setup {
                        cmd = { "gopls", "serve" },
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                },
                                staticcheck = true,
                            },
                        },
                    }
                end,
            ["jedi_language_server"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.jedi_language_server.setup{}
            end,
            ["cssls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.cssls.setup{}
            end,
            ["dockerls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.dockerls.setup{}
            end,
            ["vimls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.vimls.setup{}
            end,
            ["yamlls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.yamlls.setup{}
            end,
            ["jsonls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.jsonls.setup{}
            end,
            ["bashls"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.bashls.setup{}
            end,
            ["tailwindcss"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.tailwindcss.setup{}
            end,
            ["ansiblels"] = function()
                local lspconfig = require("lspconfig")
                lspconfig.ansiblels.setup{}
            end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        end,
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                        ["<C-Space>"] = cmp.mapping.complete(),
                    }),
                    sources = cmp.config.sources({
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' }, -- For luasnip users.
                    }, {
                        { name = 'buffer' },
                    })
                })
        end
}
