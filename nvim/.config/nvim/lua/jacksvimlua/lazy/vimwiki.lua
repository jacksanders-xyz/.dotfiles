return {
    {
        "vimwiki/vimwiki",
        config = function()
            local colors = require("kanagawa.colors").setup({ theme='wave'})

            vim.g.vimwiki_table_mappings=0
            vim.g.vimwiki_markdown_link_ext = 1
            vim.g.taskwiki_markup_syntax = 'markdown'
            vim.g.markdown_folding = 1

            vim.g.vimwiki_ext2syntax = {
                ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'
            }

            -- Vimwiki list as a Lua table (use curly braces and key-value format)
            vim.g.vimwiki_list = {
                { path = '~/VimWiki', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/RedHat', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/RedHat/DO180', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/PIPELINE', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/CLUSTER', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/AIandML', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/LANGS', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/WORKFLOW', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/jacks_brain/RANDOM', syntax = 'markdown', ext = '.md' },
                { path = '~/VimWiki/work_content', syntax = 'markdown', ext = '.md' }
            }
            vim.api.nvim_set_hl(0, 'VimwikiHeader2', {fg='#E6C384'})
            vim.api.nvim_set_hl(0, 'VimwikiHeader3', {fg="#E46876"})
            vim.api.nvim_set_hl(0, 'VimwikiHeader4', {fg="#0000ff"})
            vim.api.nvim_set_hl(0, 'VimwikiHeader5', {fg="#FFA066"})
        end
    }
}
