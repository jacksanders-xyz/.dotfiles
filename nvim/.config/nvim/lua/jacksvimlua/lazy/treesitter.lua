return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"vimdoc","org","javascript","go", "bash", "typescript", "lua","jsdoc"},

        -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = {'org'}, -- Keeps regex highlighting for org files if needed
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            }
    })
end
}

