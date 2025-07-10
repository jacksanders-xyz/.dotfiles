return {
	-- Local “plugin” = your config dir itself
	dir = vim.fn.stdpath("config"), -- ~/.config/nvim
	name = "local-task-split",

	lazy = false, -- load at startup so the map is ready

	----------------------------------------------------------------------
	-- One mapping: <leader>E  →  open the split
	----------------------------------------------------------------------
	keys = {
		{
			"<leader>E",
			function()
				require("jacksvimlua.taskwarrior").open()
			end,
			desc = "Task: list in split",
			mode = "n",
		},
	},
}
