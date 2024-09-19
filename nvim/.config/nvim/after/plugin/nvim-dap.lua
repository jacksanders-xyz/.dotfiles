-- dap stuff
local dap = require("dap")
local ui = require("dapui")

require("dapui").setup()
require("dap-go").setup({

})

require("nvim-dap-virtual-text").setup({})

-- configure other stuff later, for golange you're gonna use nvim-dap-go

-- this is command will fire it up
vim.keymap.set('n', '<F7>', dap.continue)
vim.keymap.set('n', '<F8>', dap.step_over)
vim.keymap.set('n', '<F9>', dap.step_into)
vim.keymap.set('n', '<F10>', dap.step_out)

-- shut it down
vim.api.nvim_set_keymap('n', '<leader>du', ':lua require"dapui".close()<CR>', { noremap = true, silent = true })

-- turn it off
-- vim.keymap.set('n', '<leader>D', function()
--     dap.disconnect({ terminateDebuggee = true })
--     dap.close()
-- end)

-- vim.api.nvim_set_keymap('n', '<leader>dt', ':lua require"dap".terminate()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dd', ':lua require"dap".disconnect()<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader>B', dap.set_breakpoint)

-- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
-- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
-- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

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

-- nnoremap("<leader>wk", function()
--     local command = 'KKSlider '..vim.fn.expand('%:p')
--     api.nvim_command(command)
-- end)

-- " FIRE UP
-- nnoremap <leader>dd :call StartWithMultiStatusLine()<CR>

-- " SHUT DOWN not gracefully
-- nnoremap <leader>dE :call vimspector#Reset()<CR>

-- " SHUT DOWN gracefull
-- nnoremap <leader>de :call StopWithMultiStatusLine()<CR>

-- " PICK A WINDOW (ONCE MAXIMIZED, TO TURN IT OFF JUST UNMAXIMIZE: <leader>,
-- nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
-- nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
-- nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
-- nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
-- nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
-- nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>

-- " BREAKPOINTS
-- nmap <leader>dbp <Plug>VimspectorToggleBreakpoint
-- nmap <leader>dcbp <Plug>VimspectorToggleConditionalBreakpoint
-- nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>
-- nnoremap <leader>dX :call vimspector#ClearBreakpoints()><CR>

-- " MOVEMENT
-- nmap <leader>dl <Plug>VimspectorStepInto
-- nmap <leader>dj <Plug>VimspectorStepOver
-- nmap <leader>dk <Plug>VimspectorStepOut

-- " RUN THE CODE
-- nnoremap <leader>d<space> :call vimspector#Continue()<CR>
-- nmap <leader>drc <Plug>VimspectorRunToCursor

-- " RESET CODE
-- nmap <leader>d_ <Plug>VimspectorRestart

-- " PICK A VARIABLE TO WATCH
-- nnoremap <leader>d? :call AddToWatch()<CR>
