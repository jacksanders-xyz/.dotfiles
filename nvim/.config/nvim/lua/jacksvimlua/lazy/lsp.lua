return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
        local capabilities = nil
        if pcall(require, "cmp_nvim_lsp") then
            capabilities = require("cmp_nvim_lsp").default_capabilities()
        end

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

                -- Language server specific setups
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                    path = vim.split(package.path, ';'),
                                },
                                diagnostics = {
                                    globals = {'vim'},
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
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
                        root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                        capabilities = capabilities,
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

                -- Other servers
                ["jedi_language_server"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.jedi_language_server.setup{
                        capabilities = capabilities,
                    }
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
    end
}
