return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
		{ "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" },
	},

	config = function()
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
		-- treesitter-context (sticky function header)
		--------------------------------------------------------------------------
		require("treesitter-context").setup({
			enable = true,
			multiline_threshold = 8, -- show up to 8 lines of context
			-- max_lines = 3,          -- uncomment to clamp height instead
		})

		-- vim.keymap.set("n", "<leader>tS", "<cmd>InspectTree<CR>") -- show the tree
		-- vim.keymap.set("n", "<leader>teq", "<cmd>EditQuery<CR>") -- make a query
	end,
}
