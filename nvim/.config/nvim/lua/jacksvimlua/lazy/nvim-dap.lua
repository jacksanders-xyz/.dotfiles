return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim"
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"
            require("dapui").setup()
            require("dap-go").setup()
            require("nvim-dap-virtual-text").setup()

            -- configure other stuff later, for golange you're gonna use nvim-dap-go
            -- this is command will fire it up
            vim.keymap.set('n', '<F7>', dap.continue)
            vim.keymap.set('n', '<F8>', dap.step_over)
            vim.keymap.set('n', '<F9>', dap.step_into)
            vim.keymap.set('n', '<F10>', dap.step_out)

            -- shut it down
            vim.api.nvim_set_keymap('n', '<leader>du', ':lua require"dapui".close()<CR>', { noremap = true, silent = true })

            vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
            vim.keymap.set('n', '<Leader>B', dap.set_breakpoint)
            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

            -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)

            vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
              require('dap.ui.widgets').hover()
            end)

            vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
              require('dap.ui.widgets').preview()
            end)

            vim.keymap.set('n', '<Leader>df', function()
              local widgets = require('dap.ui.widgets')
              widgets.centered_float(widgets.frames)
            end)

            vim.keymap.set('n', '<Leader>ds', function()
              local widgets = require('dap.ui.widgets')
              widgets.centered_float(widgets.scopes)
            end)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end
    }
}
