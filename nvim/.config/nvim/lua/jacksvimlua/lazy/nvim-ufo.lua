return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        -- basic fold UI
        vim.o.foldcolumn     = '1'
        vim.o.foldlevel      = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable     = true

        -- keymaps for Ufo
        vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end) -- reveal
        vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end) -- Make folds (M looks like a fold)




        vim.keymap.set('n', 'z[', function() require('ufo').goPreviousStartFold() end, {desc = 'UFO: next closed fold'})

        -- Jump + preview the fold you land on
        vim.keymap.set('n', ']z', function() require('ufo').goNextClosedFold() end, {desc = 'UFO: next closed fold'})
        vim.keymap.set('n', '[z', function() require('ufo').goPreviousClosedFold() end, {desc = 'UFO: previous closed fold'})


        -- LSP-side folding capability
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly     = true,
        }

        -- configure the servers you actually use
        local servers = { 'gopls', 'clangd', 'lua_ls' }  -- add yours here
        local lspconfig = require('lspconfig')

        for _, name in ipairs(servers) do
            -- start only if not already active
            if not vim.tbl_get(vim.lsp.get_active_clients({ name = name }), 1) then
                lspconfig[name].setup({
                    capabilities = capabilities,
                    -- other settings…
                })
            end
        end

        -- finally, start Ufo
        require('ufo').setup()
    end,
}
