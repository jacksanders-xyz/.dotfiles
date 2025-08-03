-- lua/daypart.lua
-- Reads ~/.config/env/daypart.lua and returns "morning" / "mid-day" / "night"

local filepath = vim.fn.expand("~/.config/env/daypart.lua")

local ok, chunk = pcall(loadfile, filepath)
if ok and type(chunk) == "function" then
	local ok2, part = pcall(chunk)
	if ok2 and (part == "morning" or part == "mid-day" or part == "night") then
		return part
	end
end

return "mid-day" -- fallback
