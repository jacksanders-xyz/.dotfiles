require("jacksvimlua.set")
require("jacksvimlua.remap")
require("jacksvimlua.lazy_init")
require("jacksvimlua.maximizer")

-- AUTO COMMANDS
local augroup = vim.api.nvim_create_augroup
local JacksGroup = augroup("JacksGroup", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- NORMAL CENTER
-- autocmd("VimEnter", { command = "NoNeckPain" })

-- EVERYTHING CENTER
autocmd("VimEnter", {
	callback = function()
		-- Trigger the NoNeckPain command
		vim.cmd("NoNeckPain")
		-- vim.o.showmode = true
		-- Center the custom mode indicator on the statusline
		-- vim.o.statusline = "%=%f %m %r %= %y %p%%"
	end,
})

-- CLEANLINESS IS CLOSE TO GODLINESS
autocmd({ "BufWritePre" }, {
	group = JacksGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

autocmd("LspAttach", {
	group = JacksGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)

		vim.keymap.set("n", "<leader>cws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)

		vim.keymap.set("n", "<leader>ce", function()
			vim.diagnostic.open_float(0, { scope = "line" })
		end, opts)

		-- vim.keymap.set("n", "<leader>ca", function() handled by a plugin
		-- 	vim.lsp.buf.code_action()
		-- end, opts)

		--       trouble
		--       vim.keymap.set("n", "<leader>cr", function()
		-- 	vim.lsp.buf.references()
		-- end, opts)

		vim.keymap.set("n", "<leader>cr", function()
			vim.lsp.buf.rename()
		end, opts)

		vim.keymap.set("n", "<leader>csh", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end,
})

-- K           hover()                  Show docs on symbol under cursor
-- <leader>ve  diagnostic.open_float()  Show diagnostic (error) message for current line
-- <leader>vca code_action()            Show available refactors/quick fixes
--                                      (A code action is an automated fix, suggestion, or refactor provided by your
--                                      LSP (Language Server Protocol) for the code under your cursor.)

-- <leader>vrr references()             Find all uses of current symbol
-- <leader>vrn rename()                 Rename symbol across project
-- <leader>vrh signature_help()         Show parameter hints while writing a call
-- Parameter hints are real-time popups that show you the expected parameters
-- of a function or method while you're typing it.

-- Output stuff
vim.api.nvim_create_user_command("LuaPut", function(opts)
	local ok, result = pcall(load("return " .. opts.args))
	if not ok then
		result = "Error: " .. result
	else
		result = vim.inspect(result)
	end

	-- Create a new scratch buffer
	vim.cmd("new")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, "\n"))
end, { nargs = 1 })

vim.api.nvim_create_user_command("LT", "<cmd>Lazy reload traverser<cr>", {})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- code action lightbulb
-- somewhere after plugins are loaded (bottom of init.lua is fine) ------
-- return "" when no action is available, or " 動" when it is
function _G.LightbulbStatus()
	local ok, bulb = pcall(require, "nvim-lightbulb")
	if not ok then
		return ""
	end
	local t = bulb.get_status_text()
	return (t == "") and "" or (" " .. t)
end

-- minimal status-line that keeps the default bits ______________________
-- %<%f        = trunc path
-- %h%m%r      = flags   (%m prints [+] when modified)
-- %{…}        = our kanji
-- %=          = split left / right
-- %-14.(…)%P  = line, col, percentage
vim.o.statusline = table.concat({
	"%<%f", -- file path (truncated)
	" %h%m%r", -- flags: help, [+], readonly
	"%{v:lua.LightbulbStatus()}",
	"%=", -- ───────── right side ─────────
	"%-14.(%l,%c%V%) %P",
})
