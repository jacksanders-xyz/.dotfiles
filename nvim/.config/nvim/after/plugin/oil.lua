require("oil").setup({
    default_file_explorer = true,
    columns = {'icon'},
    win_options = {
        cursorline = true
    },
    keymaps = {
        ["<C-h>"] = false,
        ["<C-s>"] = false,
    },
        view_options = {
            show_hidden = true,
        }
    })
