return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
    -- stylua: ignore
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },

        -- remote is a command somewhere else THEN something. example
       -- Delete the word over there without leaving your current spot	d r
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },

        -- do a thing like Yank a whole function in another window	y R,
        -- type part of the function’s name, pick its function label
        { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },

        -- Temporarily turn flash off for one search, example:	Press /, start typing, hit <C-s>, finish the search. or on to use
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "toggle flash search" },
    },
}
-- when pressing f it will show you the jump spots
--           [";"] = "next", -- set to `right` to always go right
--           [","] = "prev", -- set to `left` to always go left
