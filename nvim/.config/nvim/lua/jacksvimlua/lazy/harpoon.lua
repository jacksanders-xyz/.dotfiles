return {
    "ThePrimeagen/harpoon",
    config = function()
        -- Setup harpoon
        require('harpoon').setup({
            nav_first_in_list = true,
        })

        -- Import the correct submodules
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        -- Set key mappings
        vim.keymap.set('n', '<leader>a', function()
            mark.add_file()
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<C-a>', function()
            ui.toggle_quick_menu()
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<C-h>', function()
            ui.nav_file(1)
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<C-t>', function()
            ui.nav_file(2)
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<C-n>', function()
            ui.nav_file(3)
        end, { noremap = true, silent = true })

        vim.keymap.set('n', '<C-s>', function()
            ui.nav_file(4)
        end, { noremap = true, silent = true })
    end
}
