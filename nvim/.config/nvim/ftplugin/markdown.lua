
-- make vim wiki titles
vim.keymap.set('n', '<leader>TP', function()
  local title = vim.fn.expand('%:t:r')
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {'# ' .. title})
end, { noremap = true, silent = true })

-- make title formatted (remove underscores and Capitalize each word)
vim.keymap.set('n', '<leader>TFP', function()
  local title = vim.fn.expand('%:t:r')
  title = title:gsub('_', ' ')
  title = title:gsub("(%S+)", function(word)
    return word:sub(1,1):upper() .. word:sub(2):lower()
  end)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {'# ' .. title})
end, { noremap = true, silent = true })

-- CHECKBOXES FOR VIMWIKI
vim.keymap.set('n', "<leader>wl", '"*PysiW)i[]<ESC>i', { remap = true })
vim.keymap.set('n' ,"<leader>WC", ":VimwikiToggleListItem<CR>")

-- TITLE NEW PAGES
-- "VIM WIKI INSERT TITLE"
vim.api.nvim_create_user_command("VWIT", function()
  local filename = vim.fn.expand("%:t:r")
  filename = filename:gsub("[-_]", " ")
  local title = filename:lower():gsub("(%a)([%w']*)", function(first, rest)
    return first:upper() .. rest
  end)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {"# " .. title})
end, {})
