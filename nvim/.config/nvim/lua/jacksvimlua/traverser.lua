-- utils/traverser.lua  (or at the very top of edgy.lua)
local M = {}

-- Set of Traverser modes we care about
local MODE_SET = {
	traverser_lsp = true,
	traverser_symbols = true,
	traverser_incoming = true,
	traverser_outgoing = true,
}
---Return `true` if `win` is a Traverser split whose mode is in MODE_SET
function M.is_traverser(win, wanted_set)
	local t = vim.w[win].trouble
	return t and t.type == "split" and t.relative == "editor" and t.mode and (wanted_set[t.mode] or MODE_SET[t.mode])
end

---Best-effort file name for a Traverser window
function M.filename(win)
	local t = vim.w[win].trouble
	local bufnr = t and t.bufnr or vim.api.nvim_win_get_buf(win)
	if type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
		return "[No Name]"
	end
	local path = vim.api.nvim_buf_get_name(bufnr)
	if path == "" then
		return "[No Name]"
	end
	return vim.fn.fnamemodify(path, ":t")
end

return M
