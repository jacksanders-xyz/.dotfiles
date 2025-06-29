return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{
			"<leader>TT",
			function()
				require("treesj").toggle()
			end,
			desc = "Treesj: toggle split/join",
			mode = "n",
		},
	},
	opts = { use_default_keymaps = false },
}
