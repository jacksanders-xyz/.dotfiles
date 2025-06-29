return {
	{
		"MagicDuck/grug-far.nvim",
		-- Lazy-load on the user command or the keybind, whichever comes first
		cmd = "GrugFar",
		keys = {
			{ "<leader>GF", "<cmd>GrugFar<cr>", desc = "Find/Replace (grug-far)" },
		},
	},
}
