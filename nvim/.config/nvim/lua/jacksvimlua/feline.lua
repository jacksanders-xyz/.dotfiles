-- FELINE STATUS BAR
local feline = require("feline")

-- Initialize the components table
local components = {
active = {},
inactive = {}
}
require('feline').setup()
local gruvbuddy = {
	fg = "#ebdbb2",
	bg = "#32302f",
	black = "#32302f",
    white = '#f2e5bc',
    red = '#cc6666',
    pink = '#fef601',
    green = '#99cc99',
    yellow = '#f8fe7a',
    blue = '#81a2be',
    aqua = '#8ec07c',
    cyan = '#8abeb7',
    purple = '#8e6fbd',
    violet = '#b294bb',
    orange = '#de935f',
    brown = '#a3685a',
    seagreen = '#698b69',
    turquoise = '#698b69',
}


feline.use_theme(gruvbuddy)

-- local colorbuddy = {
--     NORMAL = Color.green,
--     INSERT = Color.red,
--     VISUAL = Color.magenta,
--     OP = Color.green,
--     BLOCK = Color.blue,
--     REPLACE = Color.violet,
--     ['V-REPLACE'] = Color.violet,
--     ENTER = Color.cyan,
--     MORE = Color.cyan,
--     SELECT = Color.orange,
--     COMMAND = Color.green,
--     SHELL = Color.green,
--     TERM = Color.green,
--     NONE = Color.yellow
-- }

-- local colorbuddy = {
--     green = Color.green,
--     red = Color.red,
--     magenta = Color.magenta,
--     blue = Color.blue,
--     violet = Color.violet,
--     cyan = Color.cyan,
--     orange = Color.orange,
--     yellow = Color.yellow
-- }

-- local feline_gruvbox = {
-- 	fg = "#ebdbb2",
-- 	bg = "#32302f",
-- 	black = "#32302f",
-- 	skyblue = "#83a598",
-- 	cyan = "#a89984",
-- 	green = "#98971a",
-- 	oceanblue = "#458588",
-- 	magenta = "#fb4934",
-- 	orange = "#d65d0e",
-- 	red = "#fb4934",
-- 	violet = "#b16286",
-- 	white = "#ebdbb2",
-- 	yellow = "#d79921",
-- }
-- feline.use_theme(feline_gruvbox)
