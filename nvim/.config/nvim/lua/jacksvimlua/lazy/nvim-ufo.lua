return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	-- event = "BufReadPost",
	config = function()
		-- basic fold UI
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- keymaps for Ufo
		vim.keymap.set("n", "zR", function()
			require("ufo").openAllFolds()
		end) -- reveal
		vim.keymap.set("n", "zM", function()
			require("ufo").closeAllFolds()
		end) -- Make folds (M looks like a fold)

		vim.keymap.set("n", "z[", function()
			require("ufo").goPreviousStartFold()
		end, { desc = "UFO: next closed fold" })

		-- Jump + preview the fold you land on
		vim.keymap.set("n", "]z", function()
			require("ufo").goNextClosedFold()
		end, { desc = "UFO: next closed fold" })
		vim.keymap.set("n", "[z", function()
			require("ufo").goPreviousClosedFold()
		end, { desc = "UFO: previous closed fold" })

		-- finally, start Ufo
		require("ufo").setup()
	end,
}
