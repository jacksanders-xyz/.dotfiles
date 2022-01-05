local activeMap = require('jacksvimlua.SCORE_MODE_MODULES.MODE_MAPS.scoreMaps')()
local table_copy = require('jacksvimlua.SCORE_MODE_MODULES.UTILITY_FUNCTIONS.table_copy')
local runningMap2 = table_copy(activeMap)
return function(score_layer)
  for key,value in pairs(runningMap2['n']) do
        score_layer:unmap('n', key)
  end
  -- vim.g.MI = activeMap
  -- vim.api.nvim_command("echom g:MI")
end
