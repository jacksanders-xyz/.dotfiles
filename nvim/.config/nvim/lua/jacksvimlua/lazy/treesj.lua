return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	cmd = "TSJToggle",
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})
		vim.keymap.set("n", "<leader>TT", function()
			require("treesj").toggle()
		end)
	end,
}
