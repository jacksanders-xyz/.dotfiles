local actions = require("telescope.actions")
local IPA = require("jacksvimlua.ImagePathAutomator")

require("telescope").setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " > ",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        Grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
            i = {
                -- ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
        file_browser = {
            path = "%:p:h",
            dir_icon = ''
        },
        docker = {
            binary = "docker",
        }
    },
})
require("telescope").load_extension('harpoon')
require("telescope").load_extension("fzy_native")
require("telescope").load_extension("git_worktree")
require('telescope').load_extension('bookmarks')
require('telescope').load_extension('neoclip')
require'telescope'.load_extension('zoxide')
require("telescope").load_extension("docker")
require('browser_bookmarks').setup({
  selected_browser = "chrome",
  url_open_command = "open"
})

require'neoclip'.setup({
     keys = {
        telescope = {
          i = {
            select = '<c-y>',
            paste = '<cr>',
            }
        }
    }
})

-- URLS
require("urlview").setup({
    default_title = "Links",
    default_picker = "telescope",
    log_level_min = vim.log.levels.TRACE,
    jump = {
        prev = "[U",
        next = "]U",
    },
})

local M = {}
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< .dotfiles >",
        file_ignore_patterns = {
            "%.git",
            "%.DS_Store",
        },
        hidden = true,
        cwd = '~/.dotfiles',
    })
end

M.grep_dotfiles = function()
    require("telescope.builtin").live_grep({
        prompt_title = "< Grep .dotfiles >",
        file_ignore_patterns = {
            "%.git",
            "%.DS_Store",
        },
        cwd = '~/.config/nvim',
        hidden = true,
    })
end

M.search_notes = function()
    require("telescope.builtin").find_files({
        prompt_title = "< Jack's Brain >",
        file_ignore_patterns = {
            "^IMAGE_POOL/",
            "%.git",
            "%.DS_Store",
            "^jacks_brain/MUSIC"
        },
        cwd = '~/VimWiki/',
        hidden = true,
    })
end

M.grep_notes = function()
    require("telescope.builtin").live_grep({
        prompt_title = "< Grep Jack's Brain >",
        file_ignore_patterns = {
            "^IMAGE_POOL/",
            "%.git",
            "%.DS_Store",
            "^jacks_brain/MUSIC"
        },
        cwd = '~/VimWiki/',
        hidden = true,
    })
end

local function GrabImagePath(prompt_bufnr, map)
   	local function set_the_image_path(close, Destination, editing)
		local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)[1]
        vim.g.telec = content
		if close then
			require("telescope.actions").close(prompt_bufnr)
            IPA.Telescope_Path_Constructor(content, Destination, editing)
		end
        -- leave open to possibly enter multiple images
	end

	map("i", "<c-e>", function()
		set_the_image_path(true, 'GIT_GUESS', true)
	end)

    map("i", "<c-g>", function()
		set_the_image_path(true, 'GIT_GUESS', false)
	end)

    map("i", "<CR>", function()
		set_the_image_path(true, 'LOCAL', false)
	end)

    map("i", "<c-l>", function()
		set_the_image_path(true, 'LOCAL', true)
	end)
end

M.ImagePathFinder = function()
    require("telescope.builtin").find_files({
        layout_strategy = "vertical",
        prompt_title = "< Image Finder >",
        cwd = '~/VimWiki/IMAGE_POOL/',
        previewer = false,
        file_ignore_patterns = {
            "%.git",
            "%.DS_Store",
            "%README.md",
        },
        hidden = true,
        attach_mappings = function(prompt_bufnr, map)
                GrabImagePath(prompt_bufnr, map)
                return true
        end,
    })
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

return M
