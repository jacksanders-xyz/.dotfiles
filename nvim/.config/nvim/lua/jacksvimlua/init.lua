require("jacksvimlua.sets")
require("jacksvimlua.packer")
require("jacksvimlua.remap-binder-helper")
require("jacksvimlua.harpoon")
require('jacksvimlua.treesitter')
require('jacksvimlua.orgmode')
require('jacksvimlua.ImagePathAutomator')

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

local augroup = vim.api.nvim_create_augroup
JacksGroup = augroup('JacksGroup', {})
local autocmd = vim.api.nvim_create_autocmd
-- CLEANLINESS IS CLOSE TO GODLINESS
autocmd({"BufWritePre"}, {
    group = JacksGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
