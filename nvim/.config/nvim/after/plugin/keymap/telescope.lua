local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap

-- TELESCOPE GENERAL
nnoremap("<leader>ff", function()
    require('telescope.builtin').find_files({ find_command = {'rg', '--hidden', '--files', '-g', '!node_modules/**', '-g', '!.git/**' }})
end)

nnoremap("<leader>fg", function()
    require('telescope.builtin').live_grep({
        vimgrep_arguments = {
            'rg',
            '--hidden',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-u',
        },
        file_ignore_patterns = { 'node_modules', '.git' }
    })
end)
nnoremap("<leader>fb", function()
    require('telescope.builtin').buffers()
end)
nnoremap("<leader>fh", function()
    require('telescope.builtin').help_tags()
end)
nnoremap("<C-p>", function()
    require('telescope.builtin').git_files()
end)

-- CUSTOM LOOKIN AROUND
nnoremap("<leader>fn", function() require('jacksvimlua.telescope').search_notes()
end)
nnoremap("<leader>fs", function()
	require('jacksvimlua.telescope').grep_notes()
end)
nnoremap("<leader>fdf", function()
	require('jacksvimlua.telescope').search_dotfiles()
end)
nnoremap("<leader>fdg", function()
	require('jacksvimlua.telescope').grep_dotfiles({ hidden = true })
end)

-- QFIX STUFF
nnoremap("<leader>fps", function()
	require('telescope.builtin').grep_string({ search = vim.fn.input("--Grep For > ")})
end)
nnoremap("<leader>fpw", function()
    require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }
end)
nnoremap("<leader>fpb", function()
	require('telescope.builtin').buffers()
end)

-- NEO-CLIP
nnoremap("<leader>fc", function()
	require('telescope').extensions.neoclip.default()
end)

-- ZOXIDE
nnoremap("<leader>fz", function()
    require'telescope'.extensions.zoxide.list{}
end)

-- FILE BROWSER
nnoremap("<leader>fl", function()
    require'telescope'.extensions.file_browser.file_browser()
end)

-- FIND URLS
nnoremap("<leader>fu", function()
    vim.api.nvim_command("UrlView")
end)

-- BOOKMARKS
nnoremap("<leader>fB", function()
    require('telescope').extensions.bookmarks.bookmarks()
end)

-- GIT
nnoremap("<leader>gc", function()
	require('jacksvimlua.telescope').git_branches()
end)
nnoremap("<leader>gC", function()
	require('telescope.builtin').git_commits()
end)
nnoremap("<leader>gBC", function()
	require('telescope.builtin').git_bcommits()
end)
nnoremap("<leader>gS", function()
	require('telescope.builtin').git_status()
end)
nnoremap("<leader>gw", function()
	require('telescope').extensions.git_worktree.git_worktrees()
end)
nnoremap("<leader>gM", function()
	require('telescope').extensions.git_worktree.create_git_worktree()
end)

-- Find all the functions in the buffer
-- nnoremap('<C-f>', function()
--     require('telescope.builtin').lsp_document_symbols({})
-- end)
