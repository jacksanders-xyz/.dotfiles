return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl", -- new module name since 2024
		ft = { "yaml", "python" }, -- lazy-load only for YAML buffers
		opts = {
			indent = {
				-- char = "│", -- the bar itself (any UTF-8 char works)
			},
			whitespace = {
				remove_blankline_trail = false, -- keep trailing blank lines visible
			},
			scope = { enabled = false }, -- turn off the “current scope” highlight
			exclude = {
				filetypes = { "help", "dashboard", "Trouble", "query" },
				buftypes = { "terminal", "nofile" },
			},
		},
	},
}
