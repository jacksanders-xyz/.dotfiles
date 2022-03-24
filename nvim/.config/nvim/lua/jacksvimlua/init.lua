require("jacksvimlua.telescope")
require("jacksvimlua.lsp")
require("jacksvimlua.treesitter")
require("jacksvimlua.lsp-installer")
require("jacksvimlua.feline")
require("jacksvimlua.barbar")
require("jacksvimlua.ImagePathAutomator")


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
