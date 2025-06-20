return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		{ "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" },
	},

	config = function()
		--------------------------------------------------------------------------
		-- Base Treesitter setup
		--------------------------------------------------------------------------
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"vimdoc",
				"javascript",
				"typescript",
				"go",
				"bash",
				"lua",
				"jsdoc",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},

			highlight = { enable = false }, -- keep off if you rely on regex
			indent = { enable = true },

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "gnu",
					scope_incremental = "gnU",
					node_decremental = "gnd",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
			},
		})

		--------------------------------------------------------------------------
		-- treesitter-context (sticky header)
		--------------------------------------------------------------------------
		require("treesitter-context").setup({
			enable = true,
			multiline_threshold = 8, -- show up to 8 lines of context
			-- max_lines = 3,         -- uncomment to clamp height instead
		})

		--------------------------------------------------------------------------
		-- Jump to the start of the current function  –  normal-mode `m[`
		--------------------------------------------------------------------------
		local tsu = require("nvim-treesitter.ts_utils")

		vim.keymap.set("n", "[m", function()
			-- find the enclosing function/method node
			local node = tsu.get_node_at_cursor()
			while
				node
				and not vim.tbl_contains({
					"function_definition",
					"function_declaration",
					"method_declaration",
					"function",
					"method",
				}, node:type())
			do
				node = node:parent()
			end

			if node then
				-- node:start() returns row, col (0-indexed)
				local sr, sc = node:start()
				vim.api.nvim_win_set_cursor(0, { sr + 1, sc }) -- 1-index row, keep exact col
				vim.cmd("normal! zz") -- centre screen (optional)
			else
				vim.notify("No enclosing function found", vim.log.levels.INFO)
			end
		end, { desc = "Treesitter: jump to start of current function" })

		-- Optional helpers
		-- vim.keymap.set("n", "<leader>tS", "<cmd>InspectTree<CR>")
		-- vim.keymap.set("n", "<leader>teq", "<cmd>EditQuery<CR>")
	end,
}
