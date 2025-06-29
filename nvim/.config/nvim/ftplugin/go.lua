local set = vim.opt_local

set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4

vim.keymap.set("n", "<space>gt", function()
	require("dap-go").debug_test()
end, { buffer = 0 })

vim.keymap.set("n", "<space>R", function()
	local edit_win = vim.api.nvim_get_current_win()
	vim.cmd("botright 20split")
	local term_win = vim.api.nvim_get_current_win()

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(term_win, buf)
	vim.b.go_run_term = true
	vim.fn.termopen({ "go", "run", "main.go" })

	vim.api.nvim_create_autocmd("WinClosed", {
		-- <afile> (args.match) for WinClosed is the *window ID* that just shut
		pattern = tostring(term_win),
		callback = function(args)
			-- defer to the next tick so the close finishes first
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(edit_win) then
					vim.api.nvim_set_current_win(edit_win)
				else
					-- Fallback: go to the previous window if the remembered one vanished
					vim.cmd("wincmd p")
				end
			end)
		end,
		once = true, -- fire only for this terminal window
	})
end, { buffer = 0, desc = "go run (main) in persistent terminal" })
