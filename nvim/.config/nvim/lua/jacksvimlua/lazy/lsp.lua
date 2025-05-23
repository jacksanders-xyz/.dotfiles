return {
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"artemave/workspace-diagnostics.nvim",
	},

	config = function()
		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		local function on_attach(client, bufnr)
			require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
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
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- Language server specific setups
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = vim.split(package.path, ";"),
								},
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,
				["gopls"] = function()
					require("lspconfig").gopls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							gopls = {
								analyses = { unusedparams = true },
								staticcheck = true,
								--  ⚠  remove the “local = true” line
							},
						},
					})
				end,
				-- Other servers
				["jedi_language_server"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.jedi_language_server.setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,

				-- here
				["ts_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						-- 1. root dir = first folder with a ts/js config (so the
						--    workspace spans the whole monorepo, not each package).
						root_dir = lspconfig.util.root_pattern(
							"package.json",
							"tsconfig.json",
							"jsconfig.json",
							".git"
						),

						-- 2. Don’t fall back to CWD for orphan files; prevents
						--    “workspace = /” on scratch buffers.
						single_file_support = false,

						-- 3. Extra preferences (inlay hints, etc.)
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayVariableTypeHints = true,
								},
							},
							javascript = {
								inlayHints = { includeInlayParameterNameHints = "all" },
							},
						},
					})
				end,
				-- here
				["cssls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.cssls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["dockerls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.dockerls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["vimls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.vimls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["yamlls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.yamlls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["jsonls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["bashls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.bashls.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["tailwindcss"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tailwindcss.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
				["ansiblels"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ansiblels.setup({ capabilities = capabilities, on_attach = on_attach })
				end,
			},
		})
	end,
}
