return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
            vim.keymap.set("n", "<leader>xq", function()
                require("trouble").toggle('quickfix')
            end)

            vim.keymap.set("n", "<leader>t", function()
                require("trouble").toggle('diagnostics')
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end)
        end
    },
}
