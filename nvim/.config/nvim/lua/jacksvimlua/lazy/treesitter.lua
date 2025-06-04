return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "vimdoc", "javascript", "go", "bash", "typescript", "lua", "jsdoc" }, -- Languages to install
			sync_install = false, -- Install parsers synchronously
			auto_install = true, -- Automatically install missing parsers when entering buffer
			ignore_install = {}, -- List of parsers to ignore installing
			highlight = {
				enable = false,
			},
			indent = {
				enable = true, -- Enable indentation
			},
			incremental_selection = {
				enable = true, -- Enable incremental selection
				keymaps = {
					init_selection = "gnn", -- Start selection
					node_incremental = "grn", -- Increment to next node
					scope_incremental = "grc", -- Increment to next scope
					node_decremental = "grm", -- Decrement to previous node
				},
			},
			modules = {},
		})
		-- vim.keymap.set("n", "<leader>tsi", "<cmd>InspectTree<cr>")
		vim.keymap.set("n", "<leader>teq", "<cmd>EditQuery<cr>")
	end,
}
