local M = {}

M.list_cmd = { "task", "list" } -- change to { "task", "ready" } etc.

local function feed(keys)
	local t = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(t, "n", false)
end

local function refresh(meta)
	-- close the old window, then reopen in the next tick
	if meta.win and vim.api.nvim_win_is_valid(meta.win) then
		vim.api.nvim_win_close(meta.win, true)
	end
	vim.schedule(function()
		M.open(meta.args)
	end)
end

------------------------------------------------------------------------
-- public API: open()
------------------------------------------------------------------------
function M.open(args)
	args = args or M.list_cmd

	-- remember where we started
	local origin_win = vim.api.nvim_get_current_win()
	vim.cmd("botright 20split")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_win_set_buf(win, buf)
	vim.bo[buf].filetype = "terminal"
	vim.bo[buf].buflisted = false

	-- run the task command in that buffer
	vim.fn.termopen(args)

	-- meta we keep on the buffer (for refresh)
	vim.b[buf].task_split = { win = win, origin = origin_win, args = args }

	----------------------------------------------------------------------
	-- buffer-local helper mappings --------------------------------------
	----------------------------------------------------------------------
	local opts = { buffer = buf, silent = true, desc = "task-split helper" }
	vim.keymap.set("n", "tt", function()
		feed(":!task ")
		refresh(vim.b[buf].task_split)
	end, opts) -- “task …”
	vim.keymap.set("n", "ta", function()
		feed(":!task add ")
	end, opts) -- add
	vim.keymap.set("n", "td", function()
		feed(":!task done ")
	end, opts) -- done
	vim.keymap.set("n", "tr", function()
		refresh(vim.b[buf].task_split)
	end, opts) -- refresh

	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(win),
		once = true,
		callback = function()
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(origin_win) then
					vim.api.nvim_set_current_win(origin_win)
				else
					vim.cmd("wincmd p")
				end
			end)
		end,
	})
end

return M
