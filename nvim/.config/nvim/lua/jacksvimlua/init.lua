require("jacksvimlua.set")
require("jacksvimlua.remap")
require("jacksvimlua.lazy_init")
require("jacksvimlua.maximizer")

-- AUTO COMMANDS
local augroup = vim.api.nvim_create_augroup
local JacksGroup = augroup('JacksGroup', { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- NORMAL CENTER
-- autocmd("VimEnter", { command = "NoNeckPain" })

-- EVERYTHING CENTER
autocmd("VimEnter", {
    callback = function()

        -- Trigger the NoNeckPain command
        vim.cmd("NoNeckPain")
        vim.o.showmode = true

        -- Center the custom mode indicator on the statusline
        vim.o.statusline = "%=%f %m %r %= %y %p%%"
    end,
})

-- CLEANLINESS IS CLOSE TO GODLINESS
autocmd({"BufWritePre"}, {
    group = JacksGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
autocmd('LspAttach', {
    group = JacksGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>ve", function() vim.diagnostic.open_float(0, {scope="line"}) end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vrh", function() vim.lsp.buf.signature_help() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
