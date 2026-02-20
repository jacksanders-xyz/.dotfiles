return {
	{
		"shortcuts/no-neck-pain.nvim",
		config = function()
			require("no-neck-pain").setup({
				-- width = 80,
				autocmds = {
					-- enableOnTabEnter = true,
					-- skipEnteringNoNeckPainBuffer = true,
				},
				buffers = {
					scratchPad = {
						enabled = true,
						location = "~/VimWiki/ScratchPad",
					},
					colors = {
						blend = 5,
					},
					wo = {
						fillchars = "eob: ,horiz:─,horizup:┴,horizdown:┬,vert:│,vertleft:┤,vertright:├,verthoriz:┼",
						winfixwidth = false,
					},
					bo = {
						filetype = "md",
					},
					right = {
						enabled = false,
					},
				},
			})
		end,
	},
}
