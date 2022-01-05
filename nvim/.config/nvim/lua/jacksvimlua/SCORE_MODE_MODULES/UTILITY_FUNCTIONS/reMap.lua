local activeMap = require('jacksvimlua.SCORE_MODE_MODULES.MODE_MAPS.scoreMaps')()
local table_copy = require('jacksvimlua.SCORE_MODE_MODULES.UTILITY_FUNCTIONS.table_copy')
local runningMap3 = table_copy(activeMap)
return function(score_layer)
     -- vim.g.MI = activeMap
     -- vim.api.nvim_command("echom g:MI")
  for key,value in pairs(runningMap3['n']) do
     score_layer:map('n', key, value['rhs'], {['noremap'] = true})
  end
end
-- running map is your 'blueprint' of the original maps you set (scoreMaps.lua). This way, you just grab a COPY and don't mutate the original
-- and can enter/renter as you like
