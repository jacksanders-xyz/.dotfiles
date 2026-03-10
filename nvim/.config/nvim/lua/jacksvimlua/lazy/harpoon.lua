return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				save_on_bufleave = false,
			},
		})

		local list = harpoon:list()
		local ui = harpoon.ui -- ← use the bound UI, not require("harpoon.ui")

		vim.keymap.set("n", "<leader>a", function()
			list:add()
		end, { silent = true, desc = "Harpoon add file" })
		vim.keymap.set("n", "<C-a>", function()
			ui:toggle_quick_menu(list)
		end, { noremap = true, silent = true })
		vim.keymap.set("n", "<C-h>", function()
			list:select(1)
			vim.cmd("normal! zz")
		end, { silent = true })
		vim.keymap.set("n", "<C-t>", function()
			list:select(2)
			vim.cmd("normal! zz")
		end, { silent = true })
		vim.keymap.set("n", "<C-n>", function()
			list:select(3)
			vim.cmd("normal! zz")
		end, { silent = true })
		vim.keymap.set("n", "<C-s>", function()
			list:select(4)
			vim.cmd("normal! zz")
		end, { silent = true })
	end,
}
