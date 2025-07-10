return {
	"rareitems/anki.nvim",
	opts = {
		{
			tex_support = false,
			models = {
				NoteType = "PathToDeck",
				["Basic"] = "Deck",
				["Super Basic"] = "Deck::ChildDeck",
			},
		},
	},

	keys = {
		{
			"<leader>AC",
			function()
				local path = vim.fn.expand("~/hello.anki")
				if vim.fn.filereadable(path) == 0 then
					vim.notify("File not found: " .. path, vim.log.levels.ERROR)
					return
				end

				local buf = vim.fn.bufadd(path)
				vim.fn.bufload(buf) -- actually read the file into the buffer

				local cols, rows = vim.o.columns, vim.o.lines
				local width = math.min(120, math.floor(cols * 0.5))
				local height = math.min(40, math.floor(rows * 0.8))

				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					row = math.floor((rows - height) / 2),
					col = math.floor((cols - width) / 2),
					width = width,
					height = height,
					style = "minimal",
					border = "rounded",
					title = " Anki Card ",
					title_pos = "center",
				})

				vim.schedule(function()
					if vim.api.nvim_win_is_valid(win) then
						vim.api.nvim_set_current_win(win)
						vim.cmd({ cmd = "Anki", args = { "Basic" } }) -- no E488 errors
					end
				end)
			end,
			desc = "Open ~/hello.anki in a float and run :Anki Basic",
		},
		{
			"<leader>AS",
			"<cmd>AnkiSend<cr>",
			desc = "Anki Send",
		},
	},
}
