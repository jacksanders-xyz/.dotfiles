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
				if vim.g.disable_autoformat or vim.b[args.buf].disable_autoformat then
					return
				end
				conform.format({
					bufnr = args.buf,
					async = true,
					lsp_fallback = false,
					stop_after_first = true, -- <─ replaces the old nested-table syntax
				})
			end,
		})
		local function show_notification(message, level)
			local lvl = level
			if type(level) == "string" then
				local map = {
					trace = vim.log.levels.TRACE,
					debug = vim.log.levels.DEBUG,
					info = vim.log.levels.INFO,
					warn = vim.log.levels.WARN,
					warning = vim.log.levels.WARN,
					error = vim.log.levels.ERROR,
				}
				lvl = map[level:lower()] or vim.log.levels.INFO
			end
			vim.notify(message, lvl, { title = "conform.nvim" })
		end

		vim.api.nvim_create_user_command("FormatToggle", function(args)
			local is_global = not args.bang
			if is_global then
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				if vim.g.disable_autoformat then
					show_notification("Autoformat-on-save disabled globally", "info")
				else
					show_notification("Autoformat-on-save enabled globally", "info")
				end
			else
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				if vim.b.disable_autoformat then
					show_notification("Autoformat-on-save disabled for this buffer", "info")
				else
					show_notification("Autoformat-on-save enabled for this buffer", "info")
				end
			end
		end, {
			desc = "Toggle autoformat-on-save",
			bang = true,
		})

		vim.keymap.set("n", "<leader>CT", "<cmd>FormatToggle<cr>", {
			desc = "Conform: toggle format-on-save",
			silent = true,
		})
	end,
}
