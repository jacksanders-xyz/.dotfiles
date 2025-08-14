return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = { --- add languages HERE (with formatters) AND below
			lua = { "stylua" },
			python = { "ruff_format" },
			rust = { "rustfmt" },
			javascript = { "prettierd", "prettier" }, -- fallback order
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			go = { "goimports", "gofmt" }, -- gofmt is only used if goimports   isn't available
			sh = { "shfmt" },
			json = { "jq" },
		},

		-- don’t let Conform auto-attach its own save-formatting —
		-- we’ll wire up the autocommand ourselves.
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2", "-ci", "-sr" }, -- 2-space indent, indent switch cases, simplify redirects
			},
		},
		format_on_save = false,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		------------------------------------------------------------------------
		-- Async format-on-save (includes Go this time)
		------------------------------------------------------------------------
		local grp = vim.api.nvim_create_augroup("ConformAsyncFormat", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = grp,
			pattern = { "*.lua", "*.py", "*.rs", "*.js", "*.ts", "*.tsx", "*.go", "*.sh", "*.json" }, -- need to add the language here as well
			callback = function(args)
				conform.format({
					bufnr = args.buf,
					async = true,
					lsp_fallback = false,
					stop_after_first = true, -- <─ replaces the old nested-table syntax
				})
			end,
		})
	end,
}
