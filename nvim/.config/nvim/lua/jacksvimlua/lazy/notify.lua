return {
	{
		"rcarriga/nvim-notify",
		enabled = true,
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "compact",
				stages = "static", -- Use static stage for no animation
				background_colour = "#1e1e2e",
				timeout = 2000,
				-- on_open = function(win)
				-- 	local config = vim.api.nvim_win_get_config(win)
				-- 	config.border = "none"
				-- 	vim.api.nvim_win_set_config(win, config)
				-- end,
			})
		end,
	},
	{
		"echasnovski/mini.notify",
		config = function()
			require("mini.notify").setup({})
		end,
	},
}
