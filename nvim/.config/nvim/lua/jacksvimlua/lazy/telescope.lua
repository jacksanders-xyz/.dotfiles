return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"jvgrootveld/telescope-zoxide",
			"nvim-telescope/telescope-file-browser.nvim",
			"sshelll/telescope-gott.nvim",
			"benfowler/telescope-luasnip.nvim",
			"catgoose/telescope-helpgrep.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local builtin = require("telescope.builtin")
			local open_with_trouble = require("trouble.sources.telescope").open
			-- local ts_trbl = require("trouble.sources.telescope")

			require("telescope").setup({
				defaults = {
					file_sorter = require("telescope.sorters").get_fzy_sorter,
					prompt_prefix = " > ",
					color_devicons = true,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					Grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					path_display = { "truncate" },
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					layout_config = {
						vertical = {
							preview_cutoff = 0,
							prompt_position = "top",
							preview_height = 0.50,
							width = 0.58,
							height = 100,
						},
					},
					mappings = {
						i = {
							["<C-q>"] = actions.send_to_qflist,
							["<c-t>"] = open_with_trouble, -- send to trouble
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					file_browser = {
						path = "%:p:h",
						dir_icon = "",
					},
					docker = {
						binary = "docker",
					},
				},
			})

			-- Grab your multi-grep
			local multi_rg = require("jacksvimlua.lazy.telescope.multi-ripgrep")

			-- BASIC TELE
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					find_command = { "rg", "--hidden", "--files", "-g", "!node_modules/**", "-g", "!.git/**" },
				})
			end, { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>fg", function()
				multi_rg({
					vimgrep_arguments = {
						"rg",
						"--hidden",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"-u",
					},
					file_ignore_patterns = { "node_modules", ".git" },
				})
			end, { noremap = true, silent = true })

			vim.keymap.set("n", "<c-g>", function()
				builtin.buffers({
					attach_mappings = function(_, map)
						map("i", "<c-d>", actions.delete_buffer)
						map("n", "<c-d>", actions.delete_buffer)
						return true
					end,
				})
			end)

			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fH", "<cmd>Telescope helpgrep<cr>", { noremap = true, silent = true })

			---------------------------------------------------------------------------
			--  traverser start
			---------------------------------------------------------------------------
			local action_state = require("telescope.actions.state")
			local api, fn = vim.api, vim.fn

			local function split_opts()
				local win = vim.api.nvim_get_current_win()

				-- size + absolute X-offset of the current window
				local ww = vim.api.nvim_win_get_width(win)
				local wh = vim.api.nvim_win_get_height(win)
				local win_row, win_col = unpack(vim.api.nvim_win_get_position(win))

				-- full-screen dimensions
				local ui_w, ui_h = vim.o.columns, vim.o.lines

				------------------------------------------------------------------
				-- Decide where to “anchor” the picker
				------------------------------------------------------------------
				local center_x = win_col + ww / 2 -- window’s midpoint (cells)
				local screen_mid = ui_w / 2 -- screen midpoint
				local delta = math.abs(center_x - screen_mid)

				-- local anchor = "C"
				-- 1-cell tolerance: treat  │ centered │  as “top”
				-- local anchor
				-- if delta <= 1 then
				-- 	anchor = "N" -- even → mount to the top
				-- elseif center_x < screen_mid then
				-- 	anchor = "NW"
				-- else
				-- 	anchor = "NE"
				-- end
				--
				------------------------------------------------------------------
				-- Ratios relative to the whole UI (because we’re using the stock
				-- “vertical” strategy, which positions against the screen edges)
				------------------------------------------------------------------
				local gap_left, border_w = 0, 1
				local w_ratio = (ww - gap_left - border_w) / ui_w
				local h_ratio = wh / ui_h

				return {
					border = true,
					layout_strategy = "vertical",
					previewer = false,
					layout_config = {
						vertical = {
							-- anchor = anchor,
							width = w_ratio,
							height = h_ratio,
							prompt_position = "bottom",
							preview_cutoff = 0,
						},
					},
				}
			end

			--------------------------------------------------------------------
			-- Peek action: jump in *saved* code window, refresh Trouble, stay in picker
			--------------------------------------------------------------------
			local function make_peek(code_win_id)
				return function(prompt_bufnr)
					local entry = action_state.get_selected_entry()
					if not entry then
						return
					end

					-- resolve LSP location → file / line / col
					local loc = entry.value or entry
					local file = loc.filename or (loc.uri and vim.uri_to_fname(loc.uri))
					if not file then
						return
					end
					local line = (loc.lnum or (loc.range and loc.range.start.line) or 0)
					local col = loc.col or (loc.range and loc.range.start.character) or 0

					-- validate the saved window; if it vanished, abort
					if not (code_win_id and api.nvim_win_is_valid(code_win_id)) then
						return
					end

					-- load buffer & jump (focus stays in Telescope via win_call)
					local bufnr = fn.bufadd(file)
					fn.bufload(bufnr)
					api.nvim_win_call(code_win_id, function()
						if api.nvim_win_get_buf(code_win_id) ~= bufnr then
							api.nvim_win_set_buf(code_win_id, bufnr)
						end
						api.nvim_win_set_cursor(code_win_id, { line, col })
					end)

					-- tell Trouble-symbols to refresh
					local ok, trouble = pcall(require, "trouble")
					if ok and trouble.refresh then
						trouble.refresh({ mode = "symbols" })
						trouble.refresh({ mode = "traverser_symbols" })
						trouble.refresh({ "traverser_lsp" })
						trouble.refresh({ "traverser_references" })
						trouble.refresh({ "traverser_diagnostics" })
						trouble.refresh({ "traverser_incoming" })
						trouble.refresh({ "traverser_outgoing" })
					end
				end
			end

			-- helper that spawns a symbol picker with <C-e> bound to peek --------------
			local function symbols_picker(kind) -- "buf" | "ws"
				local code_win_id = vim.api.nvim_get_current_win() -- get the windww

				local picker_fn = (kind == "ws")
						and function(opts)
							builtin.lsp_dynamic_workspace_symbols(vim.tbl_extend("force", { default_text = "" }, opts))
						end
					or builtin.lsp_document_symbols

				picker_fn(vim.tbl_extend("force", split_opts(), {
					attach_mappings = function(_, map)
						map({ "i", "n" }, "<C-e>", make_peek(code_win_id))
						return true
					end,
				}))
			end

			-- key-maps -----------------------------------------------------------------
			vim.keymap.set("n", "<C-p>", function()
				symbols_picker("buf")
			end, { desc = "Buffer symbols (peek with <C-e>)", noremap = true, silent = true })

			vim.keymap.set("n", "<leader>O", function()
				symbols_picker("ws")
			end, { desc = "Workspace symbols (peek with <C-e>)", noremap = true, silent = true })

			---------------------------------------------------------------------------
			--  traverser end
			---------------------------------------------------------------------------

			-- QFIX STUFF
			vim.keymap.set("n", "<leader>fps", function()
				builtin.grep_string({
					search = vim.fn.input("--Grep For > "),
				})
			end)
			vim.keymap.set("n", "<leader>fpw", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end)

			-- CUSTOM PICKERS -----------------------------------------------------------------
			-- Telescope “better /” with live highlights,
			--------------------------------------------------------------------

			local function telescope_buffer_search()
				local origin_win = vim.api.nvim_get_current_win()

				require("telescope.builtin").current_buffer_fuzzy_find(themes.get_dropdown({
					prompt_title = "  Buffer Search",
					layout_strategy = "vertical",
					sorting_strategy = "ascending",
					layout_config = {
						vertical = {
							preview_cutoff = 0,
							prompt_position = "top",
							preview_height = 0.50,
							width = 0.58,
							height = 100,
						},
					},

					-- previewer = true,
					-- prompt_position = "top",
					-- layout_strategy = "vertical",
					-- layout_config = {
					-- 	height = 0.68, -- total picker height = 60% of your screen
					-- 	preview_height = 0.40, -- preview-pane = 50% of that 60%
					-- },

					-- live-highlight while typing
					on_input_filter_cb = function(prompt)
						if prompt == "" then
							vim.cmd("nohlsearch")
							return false
						end
						vim.fn.setreg("/", vim.pesc(prompt))
						vim.opt.hlsearch = true
						return false
					end,

					attach_mappings = function(prompt_bufnr, map)
						local function select_and_jump()
							local entry = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							if not entry then
								return
							end

							vim.schedule(function()
								-- jump first
								if vim.api.nvim_win_is_valid(origin_win) then
									vim.api.nvim_set_current_win(origin_win)
									vim.api.nvim_win_set_cursor(origin_win, { entry.lnum, 0 })
								end
								-- then clear *all* search highlights
								vim.cmd("silent! nohlsearch") -- core search glow
								vim.opt.hlsearch = false
								vim.cmd("normal! nzz")
								-- pcall(function()
								-- 	require("hlslens").stop()
								-- end)
								-- pcall(function()
								-- 	require("flash").off()
								-- end)
							end)
						end

						local function leave_cleanly()
							actions.close(prompt_bufnr)
							vim.cmd("silent! nohlsearch") -- core search glow
							vim.opt.hlsearch = false -- keep it off
						end

						map({ "i", "n" }, "<CR>", select_and_jump)
						map({ "i", "n" }, "<C-C>", leave_cleanly)
						map({ "i", "n" }, "<C-[>>", leave_cleanly)
						return true
					end,
				}))
			end

			-- Map  <C-/>  (aka <C-_>) in Normal & Visual mode
			vim.keymap.set(
				{ "n", "x" },
				"<C-_>",
				telescope_buffer_search,
				{ desc = "Telescope: grep current buffer, feed @/ for n/N" }
			)

			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({
					prompt_title = "< Jack's Brain >",
					file_ignore_patterns = {
						"^IMAGE_POOL/",
						"%.git",
						"%.DS_Store",
						"^jacks_brain/MUSIC",
					},
					cwd = "~/VimWiki/",
					hidden = true,
				})
			end)

			vim.keymap.set("n", "<leader>fs", function()
				builtin.live_grep({
					prompt_title = "< Grep Jack's Brain >",
					file_ignore_patterns = {
						"^IMAGE_POOL/",
						"%.git",
						"%.DS_Store",
						"^jacks_brain/MUSIC",
					},
					cwd = "~/VimWiki/",
					hidden = true,
				})
			end)

			vim.keymap.set("n", "<leader>fdf", function()
				builtin.find_files({
					prompt_title = "< .dotfiles >",
					file_ignore_patterns = {
						"%.git",
						"%.DS_Store",
					},
					hidden = true,
					cwd = "~/.dotfiles",
				})
			end)

			vim.keymap.set("n", "<leader>fdg", function()
				builtin.live_grep({
					prompt_title = "< Grep .dotfiles >",
					file_ignore_patterns = {
						"%.git",
						"%.DS_Store",
					},
					cwd = "~/.config/nvim",
					hidden = true,
				})
			end)

			pcall(require("telescope").load_extension("fzf"))
			pcall(require("telescope").load_extension("helpgrep"))
			pcall(require("telescope").load_extension("luasnip"))
			pcall(require("telescope").load_extension("zoxide"))
			-- pcall(require("telescope").load_extension("godoc"))
			pcall(require("telescope").load_extension("ui-select"))

			-- GOTEST
			pcall(require("telescope").load_extension("gott"))

			-- ZOXIDE
			vim.keymap.set("n", "<leader>fz", function()
				telescope.extensions.zoxide.list({})
			end, { noremap = true, silent = true })

			-- FILE BROWSER
			vim.keymap.set("n", "<leader>fl", function()
				telescope.extensions.file_browser.file_browser({})
			end, { noremap = true, silent = true })

			-- GIT
			vim.keymap.set("n", "<leader>gc", function()
				builtin.git_branches({
					attach_mappings = function(_, map)
						map("i", "<c-d>", actions.git_delete_branch)
						map("n", "<c-d>", actions.git_delete_branch)
						return true
					end,
				})
			end)

			vim.keymap.set("n", "<leader>gC", function()
				builtin.git_commits()
			end)

			vim.keymap.set("n", "<leader>fT", "<cmd>Telescope terraform_doc<cr>", { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>gBC", function()
				builtin.git_bcommits()
			end)

			vim.keymap.set("n", "<leader>gS", function()
				builtin.git_status()
			end)

			vim.keymap.set("n", "<leader>fm", function()
				builtin.marks({ "local" })
			end)
		end,
	},
	{
		"fredrikaverpil/godoc.nvim",
		ft = "go", -- Lazy load only for Go files
		event = "VeryLazy",
		build = "go install github.com/lotusirous/gostdsym/stdsym@latest",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			{
				"nvim-treesitter/nvim-treesitter",
				opts = { ensure_installed = { "go" } },
			},
		},
		config = function()
			require("godoc").setup({})
			vim.keymap.set("n", "<leader>FG", "<cmd>GoDoc<cr>", {
				desc = "GoDoc Search",
				noremap = true,
				silent = true,
			})
		end,
	},
	{
		"ANGkeith/telescope-terraform-doc.nvim",
		ft = { "terraform", "hcl" }, -- load only in .tf / .hcl buffers
		lazy = true, -- optional; ft already makes it lazy
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			-- Telescope is already in the runtime at this point,
			-- so it’s safe to register the extension.
			require("telescope").load_extension("terraform_doc")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup({
				keys = {
					telescope = {
						i = {
							select = "<c-y>",
							paste = "<cr>",
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>fc", "<cmd>Telescope neoclip<cr>")
		end,
	},
}
