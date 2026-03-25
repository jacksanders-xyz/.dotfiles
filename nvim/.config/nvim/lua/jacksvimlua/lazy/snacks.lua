return {
	"folke/snacks.nvim",
	keys = {
		{
			"<leader>ie",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer",
		},
	},
	opts = {
		explorer = {},
		picker = {
			sources = {
				explorer = {
					layout = { layout = { width = 60 } },
				},
			},
		},
		modules = {
			bigfile = {
				disable_treesitter = true,
				disable_lsp = true,
				disable_syntax = true,
			},
		},
	},
}
