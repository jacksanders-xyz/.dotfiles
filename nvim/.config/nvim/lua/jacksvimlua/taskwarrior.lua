local M = {}

-- Default command to populate the split. Override with M.open{...} if desired.
M.list_cmd = { "task", "list" }

----------------------------------------------------------------------
-- internal helpers --------------------------------------------------
----------------------------------------------------------------------

-- feed() – push raw keys (used for launching Ex :!task ... from mappings)
local function feed(keys)
	local t = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(t, "n", false)
end

-- Find an already‑open task‑split window (if any)
-- Returns win, buf
local function find_split()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.b[buf] and vim.b[buf].task_split then
			return win, buf
		end
	end
end

-- Forward decl so setup_maps() can call back into refresh()
local setup_maps

-- Core: create + initialize a terminal buffer in a given window
-- (Used by both open() and refresh(); always creates a *new* buffer.)
local function init_task_buf(win, origin_win, args)
	-- create new scratch buffer
	local buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=true
	vim.api.nvim_win_set_buf(win, buf)

	-- terminal options
	vim.bo[buf].filetype = "terminal"
	vim.bo[buf].buflisted = false

	-- launch the task command
	local job = vim.fn.termopen(args)

	-- mark it so find_split() can detect
	vim.b[buf].task_split = {
		win = win,
		origin = origin_win,
		args = args,
	}
	vim.b[buf].job_id = job

	-- buffer‑local helper maps
	setup_maps(buf)

	return buf
end

-- Re‑map buffer‑local helper keys for a given task buffer
setup_maps = function(buf)
	local opts = { buffer = buf, silent = true, desc = "task-split helper" }

	-- interactive Ex prompts (user hits <CR> to run; then press 'tr' to refresh)
	vim.keymap.set("n", "tt", function()
		feed(":!task ")
	end, opts)

	vim.keymap.set("n", "ta", function()
		feed(":!task add project:")
	end, opts)

	vim.keymap.set("n", "tm", function()
		feed(":!task modify ")
	end, opts)

	vim.keymap.set("n", "td", function()
		feed(":!task done ")
	end, opts)

	vim.keymap.set("n", "tc", "<cmd>!/Users/jsanders/.local/bin/gen_task_project_colors.py<cr>", opts)

	-- refresh in place (no new split) — uses stored args
	vim.keymap.set("n", "tr", function()
		local meta = vim.b[buf].task_split
		local args = (meta and meta.args) or M.list_cmd
		M.refresh(args)
	end, opts)
end

----------------------------------------------------------------------
-- public API --------------------------------------------------------
----------------------------------------------------------------------

-- Toggle: close if open, otherwise open a new split
function M.toggle(args)
	local win = find_split()
	if win then
		vim.api.nvim_win_close(win, true)
	else
		M.open(args)
	end
end

-- Refresh the existing split in place (reuse window; new terminal buffer).
-- If no split exists, behaves like open().
function M.refresh(args)
	args = args or M.list_cmd
	local win, buf = find_split()
	if not win then
		M.open(args)
		return
	end

	-- preserve the original origin_win from metadata if present
	local origin_win = (vim.b[buf].task_split and vim.b[buf].task_split.origin) or vim.api.nvim_get_current_win()

	-- IMPORTANT: create a *new* terminal buffer in the existing window.
	-- We do NOT try to clear or edit the old terminal buffer (non-modifiable).
	init_task_buf(win, origin_win, args)
end

-- Open (guarded): if already open, just refresh & focus; else create split
function M.open(args)
	args = args or M.list_cmd

	-- If a split already exists, focus it & refresh instead of duplicating.
	local existing_win, _ = find_split()
	if existing_win then
		vim.api.nvim_set_current_win(existing_win)
		M.refresh(args)
		return
	end

	-- Remember where we started so we can return when the split is closed
	local origin_win = vim.api.nvim_get_current_win()

	-- Create a 20‑line bottom split
	vim.cmd("botright 20split")
	local win = vim.api.nvim_get_current_win()

	-- Initialize terminal buffer (also sets keymaps + metadata)
	local buf = init_task_buf(win, origin_win, args)

	--------------------------------------------------------------------
	-- When the window closes, bounce cursor back where user was -------
	--------------------------------------------------------------------
	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(win),
		once = true,
		callback = function()
			vim.schedule(function()
				if vim.api.nvim_win_is_valid(origin_win) then
					vim.api.nvim_set_current_win(origin_win)
				else
					-- fallback: go to previous window
					vim.cmd("wincmd p")
				end
			end)
		end,
	})
end

return M
