return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify", -- optional
		},
		config = function()
			-- Make the bottom messages split separator visible
			vim.api.nvim_set_hl(0, "NoiceSplitSeparator", { link = "Comment" })
			-- Search count view (messages.view_search = "virtualtext") uses NoiceVirtualText
			local function set_noice_hls()
				-- Dark/dim slate blue for virtual text
				if vim.o.termguicolors then
					vim.api.nvim_set_hl(0, "NoiceVirtualText", { fg = "#2d4a6a" })
				else
					-- 256-color fallback (NavyBlue)
					vim.api.nvim_set_hl(0, "NoiceVirtualText", { ctermfg = 18 })
				end
			end
			set_noice_hls()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_noice_hls,
			})
			vim.keymap.set("n", "<leader>C", "<cmd>NoiceDismiss<cr>", { noremap = true, silent = true })
			-- clear
			require("noice").setup({
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					long_message_to_split = true, -- long messages will be sent to a split
					command_palette = false,
					-- inc_rename = false,         -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
				-- Tell noice.nvim to use the "cmdline_popup" view for cmdline input.
				cmdline = {
					input_view = "cmdline",
					format = {
						cmdline = { icon = ":" },
						search_down = { icon = "/" },
						search_up = { icon = "?" },
						filter = { icon = "$" },
						lua = { icon = "☾" },
						help = { icon = "" },
						-- OPTIONAL: give shell commands their own icon
						-- shell = { pattern = "^!", icon = "!" },
					},
				},
				messages = {
					enabled = true, -- enables the Noice messages UI
					view = "mini",
					view_error = "mini", -- view for errors
					view_warn = "mini", -- view for warnings
					view_history = "messages", -- view for :messages
					view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
				},
				views = {
					cmdline_popup = {
						win_options = {
							winhighlight = {
								Normal = "NoiceCmdlinePopup",
							},
						},
					},
					mini = {
						border = { style = "single" },
						win_options = {
							winblend = 0,
							winhighlight = {
								Normal = "NoiceMini",
								FloatBorder = "NoiceMiniBorder",
							},
						},
					},
					messages = {
						backend = "split",
						enter = false,
						win_options = {
							winfixheight = true,
							winhighlight = "WinSeparator:NoiceSplitSeparator",
						},
					},
				},
			})
		end,
	},
}
