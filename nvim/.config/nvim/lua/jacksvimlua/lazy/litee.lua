return {
    {
        "ldelossa/litee.nvim",
        event = "VeryLazy",
        opts = {
            notify = { enabled = false },
            panel = {
                orientation = "bottom",
                panel_size  = 10,
            },
        },
        config = function(_, opts)
            require("litee.lib").setup(opts)
        end,
    },
    {
        "ldelossa/litee-calltree.nvim",
        dependencies = "ldelossa/litee.nvim",
        event = "VeryLazy",
        opts = {
            on_open         = "panel",
            map_resize_keys = false,
        },
        config = function(_, opts)
            require("litee.calltree").setup(opts)
            vim.keymap.set( "n", "<leader>ti", vim.lsp.buf.incoming_calls, { desc = "LSP Incoming Calls" })
            vim.keymap.set( "n", "<leader>to", vim.lsp.buf.outgoing_calls, { desc = "LSP Outgoing Calls" })
        end,
    },
}
