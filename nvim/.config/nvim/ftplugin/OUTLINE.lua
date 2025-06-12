local autocmd = vim.api.nvim_create_autocmd
local outline_group = vim.api.nvim_create_augroup("OutlineSearchOptions", { clear = true })

vim.opt.hlsearch = false
vim.opt.incsearch = false

autocmd("BufLeave", {
	group = outline_group,
	pattern = "*",
	command = "setlocal noincsearch nohlsearch",
})
