-- traverser.lua  – ext-marks ➜ in-memory store ➜ quickfix ➜ Trouble
local M, ns = {}, vim.api.nvim_create_namespace("traverser")

------------------------------------------------------------
-- 0.  State & persistence helpers
------------------------------------------------------------
local store = { -- runtime state
	active = 1, -- index into traces[]
	traces = { { name = "Trace 1", items = {} } },
}

local data_dir = vim.fn.stdpath("data") .. "/traverser"
local fname = data_dir .. "/" .. vim.fn.sha256(vim.fn.getcwd()) .. ".json"

-- lua print(vim.fn.stdpath("data") .. "/traverser" .. "/" .. vim.fn.sha256(vim.fn.getcwd()) .. ".json")
--lives here
--> /Users/jsanders/.local/share/nvim/traverser/83a804910a8b2c805386a16ce29ac3bb3dbc762047a4c9660b3dec034a68a6a4.json

local function save_state()
	vim.fn.mkdir(data_dir, "p")
	local ok, msg = pcall(vim.fn.writefile, { vim.fn.json_encode(store) }, fname)
	if not ok then
		vim.notify("Traverser save failed: " .. msg, vim.log.levels.ERROR)
	end
end

local function load_state()
	if vim.fn.filereadable(fname) == 1 then
		local ok, t = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(fname), "\n"))
		if ok and t then
			store = t
		end
	end
end
load_state()

------------------------------------------------------------
-- 1. Helper: generate “[a] …” tag for next item in trace
------------------------------------------------------------
local function next_tag(trace)
	local n = #trace.items + 1
	return string.format("[%s]", string.char(96 + n)) -- 1 → a, 2 → b, …
end

------------------------------------------------------------
-- 2. Convert current trace → quickfix list
------------------------------------------------------------
local function trace_to_qf(trace)
	local qf = {}
	for _, it in ipairs(trace.items) do
		table.insert(qf, {
			bufnr = it.bufnr,
			filename = it.filename,
			lnum = it.lnum,
			col = 1,
			text = ("%s %s"):format(it.tag, it.text),
		})
	end
	return qf
end

local function rebuild_qf()
	vim.fn.setqflist(trace_to_qf(store.traces[store.active]), "r")
end

------------------------------------------------------------
-- 3. Toggle mark at cursor (no window action)
------------------------------------------------------------
function M.toggle_here()
	local bufnr = 0
	local row = vim.api.nvim_win_get_cursor(0)[1] - 1
	local mark = vim.api.nvim_buf_get_extmarks(bufnr, ns, { row, 0 }, { row, -1 }, {})

	if #mark > 0 then -- remove mark & item
		vim.api.nvim_buf_del_extmark(bufnr, ns, mark[1][1])
		local items = store.traces[store.active].items
		for i = #items, 1, -1 do
			if items[i].bufnr == bufnr and items[i].lnum == row + 1 then
				table.remove(items, i)
			end
		end
	else -- add mark & item
		vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {})
		local trace = store.traces[store.active]
		table.insert(trace.items, {
			tag = next_tag(trace),
			bufnr = bufnr,
			filename = vim.api.nvim_buf_get_name(bufnr),
			lnum = row + 1,
			text = vim.trim(vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]),
		})
	end

	save_state()
	rebuild_qf()
	require("trouble").refresh("quickfix")
end

----------------------------------------------------------------------
-- helper: base-26 tag  (1 → a, 27 → aa, 28 → ab ...)
----------------------------------------------------------------------
local function idx_to_tag(n)
	local s = ""
	while n > 0 do
		local r = (n - 1) % 26
		s = string.char(97 + r) .. s -- 97 = 'a'
		n = math.floor((n - 1) / 26)
	end
	return ("[%s]"):format(s)
end

local function next_tag(trace)
	return idx_to_tag(#trace.items + 1)
end

----------------------------------------------------------------------
-- floating window editor  (move lines ⬆⬇, save order)
----------------------------------------------------------------------
local function open_editor()
	local trace = store.traces[store.active]
	local lines = vim.tbl_map(function(it)
		return ("%s %s"):format(it.tag, it.text)
	end, trace.items)

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "filetype", "traverser_edit")

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = math.max(30, math.floor(vim.o.columns * 0.4)),
		height = math.max(3, #lines + 2),
		row = math.floor((vim.o.lines - #lines) / 2) - 1,
		col = math.floor(vim.o.columns / 2) - 15,
		border = "rounded",
	})

	-- move current line up/down and rewrite buffer
	local function move(delta)
		local lnum = vim.api.nvim_win_get_cursor(win)[1]
		local dst = lnum + delta
		if dst < 1 or dst > #lines then
			return
		end
		lines[lnum], lines[dst] = lines[dst], lines[lnum]
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
		vim.api.nvim_win_set_cursor(win, { dst, 0 })
	end

	vim.keymap.set("n", "<C-k>", function()
		move(-1)
	end, { buffer = buf })
	vim.keymap.set("n", "<C-j>", function()
		move(1)
	end, { buffer = buf })
	vim.keymap.set("n", "q", function()
		-- save ordering back to trace
		local new = {}
		for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
			local tag, txt = line:match("^%[(.-)%]%s+(.*)$")
			for _, it in ipairs(trace.items) do
				if it.tag:sub(2, -2) == tag then
					table.insert(new, it)
					break
				end
			end
		end
		trace.items = new
		rebuild_qf()
		save_state()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })
end

function M.setup()
	vim.api.nvim_create_user_command("TraverserSwitchTrace", function()
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		pickers
			.new({}, {
				prompt_title = "Traverser Traces",
				finder = finders.new_table(vim.tbl_map(function(t)
					return t.name
				end, store.traces)),
				attach_mappings = function(_, map)
					-- delete trace
					map({ "i", "n" }, "<C-d>", function(prompt_bufnr)
						local sel = action_state.get_selected_entry()
						local idx = sel.index
						table.remove(store.traces, idx)
						if store.active > #store.traces then
							store.active = #store.traces
						end
						save_state()
						actions.close(prompt_bufnr)
					end)
					-- rename trace
					map({ "i", "n" }, "<C-r>", function()
						local sel = action_state.get_selected_entry()
						vim.ui.input({ prompt = "Rename trace to: ", default = sel[1] }, function(new)
							if new and new ~= "" then
								store.traces[sel.index].name = new
								save_state()
								rebuild_qf()
								require("trouble").refresh("quickfix")
							end
						end)
					end)
					actions.select_default:replace(function(prompt_bufnr)
						local sel = action_state.get_selected_entry()
						store.active = sel.index
						actions.close(prompt_bufnr)
						rebuild_qf()
						require("trouble").open("quickfix")
					end)
					return true
				end,
			})
			:find()
	end, {})
	----------------------------------------------------------------------
	-- New trace helper  (called by the user-command)
	----------------------------------------------------------------------
	local function new_trace(name)
		name = (name and name ~= "") and name or ("Trace " .. (#store.traces + 1))

		table.insert(store.traces, { name = name, items = {} })
		store.active = #store.traces
		save_state()

		rebuild_qf() -- update list right away
		require("trouble").refresh("quickfix") -- live refresh if pane is open
		vim.notify("Traverser: created " .. name)
	end

	----------------------------------------------------------------------
	-- :TraverserNewTrace  {optional-name}
	----------------------------------------------------------------------
	vim.api.nvim_create_user_command("TraverserNewTrace", function(opts)
		new_trace(opts.args)
	end, { nargs = "?", complete = "file" })

	----------------------------------------------------------------------
	-- (the <leader>tN mapping you already added elsewhere stays unchanged)
	-- map("n", "<leader>tN", "<Cmd>TraverserNewTrace<CR>", { desc = "Traverser: new trace" })
	----------------------------------------------------------------------

	----------------------------------------------------------------------
	-- JUMP‐TO‐TAG  –  :TraverserJump {tag}  /  <leader>tc
	----------------------------------------------------------------------
	local function jump_to_tag(tag)
		tag = tag:lower()
		for _, it in ipairs(store.traces[store.active].items) do
			if it.tag:sub(2, -2):lower() == tag then
				----------------------------------------------------------
				-- resolve buffer (might not be loaded)
				----------------------------------------------------------
				local bufnr = (it.bufnr and it.bufnr > 0) and it.bufnr or vim.fn.bufadd(it.filename)
				vim.fn.bufload(bufnr)

				----------------------------------------------------------
				-- jump
				----------------------------------------------------------
				vim.api.nvim_set_current_buf(bufnr)
				vim.api.nvim_win_set_cursor(0, { it.lnum, (it.col or 1) - 1 })
				vim.cmd("normal! zv") -- open folds
				return
			end
		end
		vim.notify("Traverser: tag [" .. tag .. "] not found", vim.log.levels.WARN)
	end

	vim.api.nvim_create_user_command("TraverserJump", function(opts)
		if opts.args == "" then
			vim.notify("TraverserJump requires a tag (e.g. a, z, aa)", vim.log.levels.ERROR)
		else
			jump_to_tag(opts.args)
		end
	end, {
		nargs = 1,
		complete = function(_, line)
			-- completion list = current trace tags (without brackets)
			local lword = line:match("%S+$") or ""
			local t = {}
			for _, it in ipairs(store.traces[store.active].items) do
				table.insert(t, it.tag:sub(2, -2))
			end
			return vim.tbl_filter(function(x)
				return x:match("^" .. lword)
			end, t)
		end,
	})
	vim.api.nvim_create_user_command("TraverserAddNode", function()
		M.toggle_here()
	end, {})

	vim.api.nvim_create_user_command("TraverserTree", function()
		rebuild_qf()
		require("trouble").toggle("traverser_tree")
	end, {})

	vim.api.nvim_create_user_command("TraverserEdit", function()
		vim.notify("TODO: implement re-ordering UI")
	end, {})

	vim.api.nvim_create_user_command("TraverserNewTrace", function(opts)
		new_trace(opts.args)
	end, { nargs = "?", complete = "file" })

	vim.api.nvim_create_user_command("TraverserEdit", open_editor, {})
	local map = vim.keymap.set
	map("n", "<leader>ta", "<Cmd>TraverserAddNode<CR>", { desc = "Traverser: add/remove node" })
	map("n", "<leader>ty", "<Cmd>TraverserTree<CR>", { desc = "Traverser: open tree" })
	map("n", "<leader>tN", "<Cmd>TraverserNewTrace<CR>", { desc = "Traverser: new trace" })
	map("n", "<leader>tS", "<Cmd>TraverserSwitchTrace<CR>", { desc = "Traverser: switch trace" })
	map("n", "<leader>tE", "<Cmd>TraverserEdit<CR>", { desc = "Traverser: edit trace list" })
	map("n", "<leader>tc", function()
		vim.ui.input({ prompt = "Jump to tag: " }, function(input)
			if input and input ~= "" then
				jump_to_tag(input)
			end
		end)
	end, { desc = "Traverser: jump to tag" })
	vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_state })
end

return M
