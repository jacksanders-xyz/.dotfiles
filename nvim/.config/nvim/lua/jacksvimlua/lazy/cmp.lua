return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		priority = 100,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		},

		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local lspkind = require("lspkind")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- for `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- navigate through the items and insert them without confirming
					["<c-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<c-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "text",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labeldetails = true,
						menu = {
							nvim_lsp = "[lsp]",
							path = "[path]",
							nvim_lua = "[lua]",
							buffer = "[buffer]",
							luasnip = "[luasnip]",
						},
					}),
				},
			})
		end,
	},
}
