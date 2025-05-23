return {
	"windwp/nvim-ts-autotag",
	opts = {},
	config = function(_, opts)
		require("nvim-ts-autotag").setup(opts)
	end,
}
