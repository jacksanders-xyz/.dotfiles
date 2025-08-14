return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"artemave/workspace-diagnostics.nvim",
			-- {
			-- 	"j-hui/fidget.nvim",
			-- 	tag = "v1.0.0",
			-- 	opts = {}, -- or use config if you want a function call
			-- },
		},
		config = function()
			-- add cmp capabilities if available
			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			-- workspace diagnostics on_attach
			local function on_attach(client, bufnr)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
			end

			-- require("fidget").setup({})
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"gopls",
					-- add more servers here if you want
				},

				-- use the legacy `handlers` table (no setup_handlers call)
				handlers = {
					-- fallback for all servers _except_ the ones you special-case below
					function(server_name)
						if server_name == "gopls" then
							return -- skip generic setup for gopls
						end

						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- lua_ls
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
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

					-- gopls
					["gopls"] = function()
						require("lspconfig").gopls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
							settings = {
								gopls = {
									analyses = { unusedparams = true },
									staticcheck = true,
								},
							},
						})
					end,

					-- jedi_language_server
					["jedi_language_server"] = function()
						require("lspconfig").jedi_language_server.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- ts_ls
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
							root_dir = require("lspconfig.util").root_pattern(
								"package.json",
								"tsconfig.json",
								"jsconfig.json",
								".git"
							),
							single_file_support = false,
							settings = {
								typescript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
										includeInlayVariableTypeHints = true,
									},
								},
								javascript = {
									inlayHints = {
										includeInlayParameterNameHints = "all",
									},
								},
							},
						})
					end,

					-- cssls
					["cssls"] = function()
						require("lspconfig").cssls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- dockerls
					["dockerls"] = function()
						require("lspconfig").dockerls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- vimls
					["vimls"] = function()
						require("lspconfig").vimls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- yamlls
					["yamlls"] = function()
						require("lspconfig").yamlls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- jsonls
					["jsonls"] = function()
						require("lspconfig").jsonls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- bashls
					["bashls"] = function()
						require("lspconfig").bashls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- tailwindcss
					["tailwindcss"] = function()
						require("lspconfig").tailwindcss.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- css
					["cssls"] = function()
						require("lspconfig").cssls.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,

					-- ansiblels
					["ansiblels"] = function()
						require("lspconfig").ansiblels.setup({
							capabilities = capabilities,
							on_attach = on_attach,
						})
					end,
				},
			})
		end,
	},
}
