-- lua/daypart.lua
-- Returns "morning" | "mid-day" | "night" (default: "mid-day")

local path = vim.fn.expand("~/.config/env/daypart.zsh")
local file = io.open(path, "r")

if file then
	local line = file:read("*l") -- "export DAYPART=night"
	file:close()
	local val = line and line:match("DAYPART%s*=%s*(%S+)")
	print(val)
	if val == "morning" or val == "mid-day" or val == "night" then
		return val
	end
end
return "mid-day"
