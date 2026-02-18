-- preview links in a float
vim.keymap.set("n", "<leader>wp", function()
	require("jacksvimlua.md_link_preview").preview_link()
end, { buffer = true, silent = true, desc = "Preview link (float)" })

-- make vim wiki titles
vim.keymap.set("n", "<leader>TP", function()
	local title = vim.fn.expand("%:t:r")
	vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. title })
end, { noremap = true, silent = true })

-- make title formatted (remove underscores and Capitalize each word)
vim.keymap.set("n", "<leader>TFP", function()
	local title = vim.fn.expand("%:t:r")
	title = title:gsub("_", " ")
	title = title:gsub("(%S+)", function(word)
		return word:sub(1, 1):upper() .. word:sub(2):lower()
	end)
	vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. title })
end, { noremap = true, silent = true })

-- CHECKBOXES FOR VIMWIKI
vim.keymap.set("n", "<leader>wl", '"*PysiW)i[]<ESC>i', { remap = true })
vim.keymap.set("n", "<leader>WC", ":VimwikiToggleListItem<CR>")

-- "VIM WIKI INSERT TITLE"
vim.api.nvim_create_user_command("VWIT", function()
	local filename = vim.fn.expand("%:t:r")
	filename = filename:gsub("[-_]", " ")
	local title = filename:lower():gsub("(%a)([%w']*)", function(first, rest)
		return first:upper() .. rest
	end)
	vim.api.nvim_buf_set_lines(0, 0, 0, false, { "# " .. title })
end, {})

-- "VIM WIKI RELATIVE PATH"
vim.api.nvim_create_user_command("VWRP", function()
	local curr_path = vim.fn.expand("%:p:h")
	local tar_path = vim.fn.expand(vim.fn.getreg("*"))
	local res = vim.system({ "grealpath", "--relative-to=" .. curr_path, tar_path }):wait()

	if res.code ~= 0 then
		vim.notify(res.stderr or "grealpath failed", vim.log.levels.ERROR)
		return
	end

	vim.api.nvim_put({ "[](" .. vim.trim(res.stdout) .. ")" }, "c", true, true)
end, {})
