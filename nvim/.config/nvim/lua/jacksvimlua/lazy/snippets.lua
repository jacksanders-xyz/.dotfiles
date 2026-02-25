return {
	{
		"L3MON4D3/LuaSnip",
		-- version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		-- build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", { "jsdoc" })

			-- Load custom markdown snippets
			ls.add_snippets("markdown", require("jacksvimlua.snippets.markdown"))

			vim.keymap.set({ "i" }, "<C-s>e", function()
				ls.expand()
			end, { silent = true }) -- expand snippet
			vim.keymap.set({ "i", "s" }, "<C-s>;", function()
				ls.jump(1)
			end, { silent = true }) -- jump forward in the snippet
			vim.keymap.set({ "i", "s" }, "<C-s>,", function()
				ls.jump(-1)
			end, { silent = true }) -- jump back in the snippet
			vim.keymap.set({ "i", "s" }, "<C-E>", function() -- lua snip choice change
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
			-- Usage: Type the trigger (e.g., subnote), then press <C-s>e to expand. Use <C-s>; to jump to the next placeholder.

			-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/") reload snippet file
		end,
	},
}
