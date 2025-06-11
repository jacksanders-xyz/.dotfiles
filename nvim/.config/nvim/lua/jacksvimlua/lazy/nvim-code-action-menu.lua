return {
	"aznhe21/actions-preview.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" }, -- you already have it
	config = function()
		local ap = require("actions-preview")
		-- reuse your <leader>ca mapping
		vim.keymap.set({ "n", "v" }, "<leader>ca", ap.code_actions, { desc = "Code Action (preview)" })
		ap.setup({
			backend = { "telescope" }, -- uses your Telescope layout
			diff = { ctxlen = 3 }, -- 3-line unified diff preview
		})
	end,
}
