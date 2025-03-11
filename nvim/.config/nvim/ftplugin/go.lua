local set = vim.opt_local

set.expandtab = false
set.tabstop = 4
set.shiftwidth = 4

vim.keymap.set("n", "<space>td", function()
  require("dap-go").debug_test()
end, { buffer = 0 })

vim.keymap.set("n", "<space>R", "<cmd>!go run main.go<cr>", { buffer = 0 })
