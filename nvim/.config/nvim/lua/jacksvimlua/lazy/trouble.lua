return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
            vim.keymap.set("n", "<leader>xq", function()
                require("trouble").toggle('quickfix')
            end)

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle('diagnostics')
            end)

            vim.keymap.set("n", "<leader>tf", "<cmd>Trouble symbols toggle win.position=left<cr>")

            vim.keymap.set("n", "<leader>J", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "<leader>K", function()
                require("trouble").prev({skip_groups = true, jump = true});
            end)
        end
    },
}
