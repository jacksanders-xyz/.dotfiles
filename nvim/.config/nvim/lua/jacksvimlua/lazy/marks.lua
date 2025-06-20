return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	config = function()
		require("marks").setup({
			-- default_mappings = true,
			signs = true,
			mappings = {
				delete_buf = "<C-\\>",
			},
			persist_marks = true,
		})
	end,
}
