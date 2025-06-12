return {
	dir = vim.fn.stdpath("config") .. "/lua/jacksvimlua",
	name = "traverser",
	dependencies = { "folke/trouble.nvim" },
	config = function()
		require("jacksvimlua.traverser").setup()
	end,
}
