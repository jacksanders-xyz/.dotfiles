return {
	dir = vim.fn.stdpath("config"), -- ~/.config/nvim
	name = "local-task-split",
	lazy = false,

	--- Toggle the Task‑warrior split with <leader>E ----------------------
	keys = {
		{
			"<leader>E",
			function()
				require("jacksvimlua.taskwarrior").toggle()
			end,
			desc = "Task: list in split (toggle)",
			mode = "n",
		},
	},
}
