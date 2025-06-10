return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {}, -- your autopairs options
	config = function(_, opts)
		-- 1. Standard autopairs setup
		require("nvim-autopairs").setup(opts)

		-- 2. cmp integration
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
