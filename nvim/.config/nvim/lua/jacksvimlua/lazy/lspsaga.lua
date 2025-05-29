return {
	"nvimdev/lspsaga.nvim",
	branch = "main",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("lspsaga").setup({
			lightbulb = { enable = false },
		})
		-- symbol_in_winbar = { enable = false },

		-- vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>",
		--   { desc = "Incoming Calls" })
		-- vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>",
		--   { desc = "Outgoing Calls" })
	end,
}
