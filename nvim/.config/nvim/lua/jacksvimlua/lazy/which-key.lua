return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			triggers = { "z" },
		},
		plugins = {
			spelling = {
				enabled = true, -- show suggestions on z=
				suggestions = 40, -- how many to show
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
