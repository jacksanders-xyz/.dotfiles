return {
	{
		"rcarriga/nvim-notify",
		enabled = true,
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "compact",
				stages = "static", -- Use static stage for no animation
				timeout = 2000,
				on_open = function(win)
					local config = vim.api.nvim_win_get_config(win)
					config.border = "none"
					vim.api.nvim_win_set_config(win, config)
				end,
			})
		end,
	},
}
