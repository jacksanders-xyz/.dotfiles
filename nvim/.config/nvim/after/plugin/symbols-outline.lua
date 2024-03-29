local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap
require("symbols-outline").setup({
    show_relative_numbers = true,
    position = 'left',
    symbol_blacklist  = {
        'File',
        'Module',
        'Namespace',
        'Package',
        'Class',
        'Method',
        'Property',
        'Field',
        'Constructor',
        'Enum',
        'Interface',
        'String',
        'Number',
        'Boolean',
        'Array',
        'Object',
        'Key',
        'Null',
        'EnumMember',
        'Struct',
        'Event',
        'Operator',
        'TypeParameter',
        'Component',
        'Fragment',
    },
    symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "𝓒", hl = "@type" },
        Method = { icon = "ƒ", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "ƒ", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "🔐", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "🗲", hl = "@type" },
        Operator = { icon = "+", hl = "@operator" },
        TypeParameter = { icon = "𝙏", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
    },
})

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "OUTLINE [-]" then
            vim.o.incsearch = true
        end
    end
})

vim.api.nvim_create_autocmd("BufLeave", {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "OUTLINE [-]" then
            vim.o.incsearch = false
        end
    end
})

-- symbol_blacklist  = {
--         'File',
--         'Module',
--         'Namespace',
--         'Package',
--         'Class',
--         'Method',
--         'Property',
--         'Field',
--         'Constructor',
--         'Enum',
--         'Interface',
--         'Function',
--         'Variable',
--         'Constant',
--         'String',
--         'Number',
--         'Boolean',
--         'Array',
--         'Object',
--         'Key',
--         'Null',
--         'EnumMember',
--         'Struct',
--         'Event',
--         'Operator',
--         'TypeParameter',
--         'Component',
--         'Fragment',
--     }
