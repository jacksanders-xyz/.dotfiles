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

		-- Calmer fold line colors (catppuccin)
		vim.api.nvim_set_hl(0, "Folded", { bg = "#313244", fg = "#a6adc8" }) -- surface0 bg, subtext0 fg
		vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { fg = "#6c7086" }) -- overlay0 (muted)

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

		vim.keymap.set("n", "zK", function()
			require("ufo").peekFoldedLinesUnderCursor()
		end, { desc = "UFO: preview fold" })

		-- Fold subnote (includes the [!SUBNOTE] title line)
		vim.keymap.set("n", "zC", function()
			-- Search backward for ``` (opening fence)
			local fence_start = vim.fn.search("^```", "bnW")
			-- Check if line above is a [!SUBNOTE] callout
			local start_line = fence_start
			if fence_start > 1 then
				local line_above = vim.fn.getline(fence_start - 1)
				if line_above:match("%[!SUBNOTE%]") then
					start_line = fence_start - 1
				end
			end
			-- Search forward for closing ```
			local end_line = vim.fn.search("^```", "nW")
			if start_line > 0 and end_line > 0 then
				vim.cmd(start_line .. "," .. end_line .. "fold")
			end
		end, { desc = "UFO: fold subnote under cursor" })

		-- Custom fold text handler with ↳ arrow for subnotes
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" ↳ %d lines"):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "Comment" })
			return newVirtText
		end

		-- finally, start Ufo
		require("ufo").setup({
			fold_virt_text_handler = handler,
		})
	end,
}
-- 1. zC - When your cursor is inside a code block, press zC to fold it immediately
--      2. vac then zf - Visual select around code block, then create fold (ok to
--      make selection +1)
