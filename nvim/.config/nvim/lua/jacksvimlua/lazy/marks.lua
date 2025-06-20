return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = function()
		require("marks").setup({
			default_mappings = true,
			signs = true,
			mappings = {
				next = "m]",
				prev = "m[",
				delete_buf = "<C-\\>",
			},
			persist_marks = true,
		})
	end,
}
