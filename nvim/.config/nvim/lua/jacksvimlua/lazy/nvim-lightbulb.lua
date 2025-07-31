return {
	"kosayoda/nvim-lightbulb",
	event = { "LspAttach" },
	opts = {
		-- we don’t want a gutter icon ▼
		sign = {
			enabled = false,
			text = "動",
			lens_text = "動",
			hl = "LightBulbDimmer",
		},

		-- no inline virtual-text mark ▼
		virtual_text = { enabled = false },

		-- DO show a status-line indicator ▼
		status_text = {
			enabled = true,
			text = "動",
			hl = "LightBulbDimmer",
		},

		-- number = {
		-- 	enabled = true,
		-- 	-- Highlight group to highlight the number column if there is a lightbulb.
		-- 	hl = "LightBulbNumber",
		-- },
	},
	config = function(_, opts)
		local bulb = require("nvim-lightbulb")
		bulb.setup(opts)

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group = vim.api.nvim_create_augroup("LightBulbDim", { clear = true }),
			callback = bulb.update_lightbulb,
		})
	end,
}
