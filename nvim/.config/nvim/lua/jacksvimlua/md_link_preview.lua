local M = {}

local function trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function resolve_path(target)
	target = trim(target)
	target = target:gsub("^file://", "")

	local path, anchor = target, nil
	local hash = target:find("#", 1, true)
	if hash then
		path = target:sub(1, hash - 1)
		anchor = target:sub(hash + 1)
		if anchor == "" then
			anchor = nil
		end
	end

	if path == "" then
		path = vim.api.nvim_buf_get_name(0)
	elseif not path:match("^/") then
		local base = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
		path = base .. "/" .. path
	end

	path = vim.fs.normalize(path)
	return path, anchor
end

local function link_under_cursor()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-based

	-- [text](target)
	do
		local i = 1
		while true do
			local s, e, _txt, target = line:find("%[([^%]]-)%]%(([^)]+)%)", i)
			if not s then
				break
			end
			if col >= s and col <= e then
				return { kind = "md", target = trim(target) }
			end
			i = e + 1
		end
	end

	-- Vimwiki [[target|desc]] or [[target]]
	do
		local i = 1
		while true do
			local s, e, inner = line:find("%[%[([^%]]-)%]%]", i)
			if not s then
				break
			end
			if col >= s and col <= e then
				inner = trim(inner)
				local target = inner:match("^([^|]+)") or inner
				return { kind = "wiki", target = trim(target) }
			end
			i = e + 1
		end
	end

	-- <https://...>
	do
		local i = 1
		while true do
			local s, e, url = line:find("<(https?://[^>]+)>", i)
			if not s then
				break
			end
			if col >= s and col <= e then
				return { kind = "url", target = trim(url) }
			end
			i = e + 1
		end
	end

	-- bare https://...
	do
		local i = 1
		while true do
			local s, e, url = line:find("(https?://%S+)", i)
			if not s then
				break
			end
			if col >= s and col <= e then
				url = url:gsub("[%)%]%}%.,;:!%?]+$", "")
				return { kind = "url", target = trim(url) }
			end
			i = e + 1
		end
	end

	return nil
end

local function open_float(lines)
	local opts = {
		border = "rounded",
		max_width = math.floor(vim.o.columns * 0.85),
		max_height = math.floor(vim.o.lines * 0.5),
		wrap = true,
		focusable = true,
	}
	vim.lsp.util.open_floating_preview(lines, "markdown", opts)
end

function M.preview_link()
	local link = link_under_cursor()
	if not link then
		pcall(vim.lsp.buf.hover)
		return
	end

	if link.kind == "url" or link.target:match("^https?://") then
		open_float({ "URL:", "", link.target })
		return
	end

	local path, anchor = resolve_path(link.target)
	if vim.fn.filereadable(path) ~= 1 then
		open_float({ "Not a readable file:", "", path })
		return
	end

	local max_lines = 200
	local lines = vim.fn.readfile(path, "", max_lines)
	if #lines == 0 then
		open_float({ path, "", "(empty file)" })
		return
	end

	local start_idx = 1
	if anchor then
		local needle = anchor:gsub("[-_]", " "):lower()
		for i, l in ipairs(lines) do
			local ll = l:lower()
			if ll:find(anchor:lower(), 1, true) or ll:find(needle, 1, true) then
				start_idx = math.max(1, i - 10)
				break
			end
		end
	end

	local snippet = {}
	for i = start_idx, math.min(#lines, start_idx + 80) do
		table.insert(snippet, lines[i])
	end

	local ft = vim.filetype.match({ filename = path }) or ""
	local md = { path, "", "```" .. ft }
	vim.list_extend(md, snippet)
	table.insert(md, "```")

	open_float(md)
end

return M
