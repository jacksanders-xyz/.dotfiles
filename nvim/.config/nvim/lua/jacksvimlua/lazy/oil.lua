return {
    {
      "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                columns = {},
                win_options = {
                    cursorline = false
                },
                keymaps = {
                    ["<C-h>"] = false,
                    ["<C-s>"] = false,
                    ["gs"] = false,
                },
                    view_options = {
                        show_hidden = true,
                    }
                })
        end
    }
}
