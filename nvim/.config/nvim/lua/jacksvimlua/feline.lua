-- FELINE STATUS BAR
--[[
  __      _ _                         _
 / _| ___| (_)_ __   ___   _ ____   _(_)_ __ ___
| |_ / _ \ | | '_ \ / _ \ | '_ \ \ / / | '_ ` _ \
|  _|  __/ | | | | |  __/_| | | \ V /| | | | | | |
|_|  \___|_|_|_| |_|\___(_)_| |_|\_/ |_|_| |_| |_|
/* IMPORTS */
--]]

-- local highlight = require('highlite').highlight

--[[/* CONSTANTS */]]
local vi_mode_utils = require("feline.providers.vi_mode")
local feline = require("feline")
-- local CurrProfile = os.getenv("ITERM_PROFILE")
local _BUF_ICON =
{ -- {{{

        dbui     = '  ',


        diff     = ' 繁',


        help     = '  ',


        NvimTree = ' פּ ',


        packer   = '  ',


        qf       = '  ',

        undotree = '  ',

        vista    = '  ',

        vista_kind = '  ',

        vista_markdown = '  ',
} -- }}}
-- ┼
                -- ﬀ use this maybe?

local gitsigns = require('gitsigns').setup()

-- ('white',     '#f2e5bc')
-- ('red',       '#cc6666')
-- ('pink',      '#fef601')
-- ('green',     '#99cc99')
-- ('yellow',    '#f8fe7a')
-- ('blue',      '#81a2be')
-- ('aqua',      '#8ec07c')
-- ('cyan',      '#8abeb7')
-- ('purple',    '#8e6fbd')
-- ('violet',    '#b294bb')
-- ('orange',    '#de935f')
-- ('brown',     '#a3685a')
-- ('seagreen',  '#698b69')
-- ('turquoise', '#698b69')



-- Defined in https://github.com/Iron-E/nvim-highlite
local _BLACK       = {'#202020', 235, 'black'}
local _GRAY        = {'#808080', 244, 'gray'}
local _GRAY_DARK   = {'#353535', 236, 'darkgrey'}
--local _GRAY_DARKER = {'#505050', 239, 'gray'}
local _GRAY_LIGHT  = {'#c0c0c0', 250, 'gray'}
local _WHITE       = {'#f2e5bc', 231, 'white'}

local _TAN = {'#f4c069', 221, 'yellow'}

local _RED       = {'#cc6666', 203, 'red'}
local _RED_DARK  = {'#a80000', 124, 'darkred'}
local _RED_LIGHT = {'#ff4090', 205, 'red'}

local _BROWN = {'#a3685a', 205, 'brown'}

local _ORANGE       = {'#de935f', 208, 'darkyellow'}
local _ORANGE_LIGHT = {'#f0af00', 214, 'darkyellow'}

local _YELLOW = {'#f8fe7a', 227, 'yellow'}
local _OLD_CONFIG_YELLOW = {'#b3b309', 227, 'yellow'}

local _WEIRD_PINK = {'#b8376c', 227, 'yellow'}


local _CELADON_GREEN       = {'#048A81', 46,  'green'}
local _PTHALO_GREEN       = {'#012622', 46,  'green'}

local _GREEN_DARK  = {'#99cc99', 113, 'darkgreen'}
local _GREEN       = {'#22ff22', 46,  'green'}
local _NU_GREEN       = {'#0b530b', 46,  'green'}
local _NU_GREEN2       = {'#0a880a', 46,  'green'}
local _GREEN_LIGHT = {'#99ff99', 120, 'green'}
local _TURQUOISE    = {'#698b69', 48,  'green'}
local _SEAGREEN    = {'#698b69', 48,  'seagreen'}


local _PINE = {'#292E1E'}
local _MID_TURQUOISE = {'#4ECDC4'}
local _COFFEE = {'#A77E58'}
local _RUST = {'#BA3F1D'}

local _CADET_BLUE = {'#66999B', 63,  'darkblue'}

local _BLUE = {'#81a2be', 63,  'darkblue'}
local _TMUXDARK = {'#57577b', 63,  'darkblue'}
local _TMUXBLUE = {'#5b5b81', 63,  'blue'}
local _TMUXBLUE_LIGHT = {'#7878aa', 63,  'lightblue'}
local _AQUA = {'#8ec07c', 63,  'aqua'}
local _CYAN = {'#8abeb7', 80,  'cyan'}
local _ICE  = {'#95c5ff', 111, 'cyan'}
local _TEAL = {'#60afff', 75,  'blue'}

local _MAGENTA      = {'#d5508f', 168, 'magenta'}
local _MAGENTA_DARK = {'#bb0099', 126, 'darkmagenta'}
local _PINK         = {'#fef601', 219, 'magenta'}
local _PINK_LIGHT   = {'#ffb7b7', 217, 'white'}
local _PURPLE       = {'#8e6fbd', 171, 'magenta'}
local _PURPLE_LIGHT = {'#af60af', 133, 'darkmagenta'}
local _VIOLET = {'#b294bb', 133, 'violet'}

local FILE_MODIFIED_ICON
local FMI_SET = function()
    -- ┼
    local prof_dict = {
        ['BASE_PROF'] = '┼ ',
        ['DICTATOR_PROF'] = 'ﬀ  '
    }
    local CurrProfile = vim.g.FelineItermProf
    -- FILE_MODIFIED_ICON = prof_dict[CurrProfile]
    return prof_dict[CurrProfile]
end
FMI_SET()

local _SIDEBAR = _BLACK
local _MIDBAR = _GRAY_DARK
local _TEXT = _GRAY_LIGHT

local _MODES =
{ -- {{{
	['c']  = {'COMMAND-LINE',      _COFFEE},
	['ce'] = {'NORMAL EX',         _RED_DARK},
	['cv'] = {'EX',                _RED_LIGHT},
	['i']  = {'INSERT',            _NU_GREEN},
	['ic'] = {'INS-COMPLETE',      _NU_GREEN},
	['n']  = {'NORMAL',            _TMUXBLUE},
	['no'] = {'OPERATOR-PENDING',  _PURPLE},
	['r']  = {'HIT-ENTER',         _CYAN},
	['r?'] = {':CONFIRM',          _CYAN},
	['rm'] = {'--MORE',            _ICE},
	['R']  = {'REPLACE',           _PINK},
	['Rv'] = {'VIRTUAL',           _PINK_LIGHT},
    ['s']  = {'SELECT',            _TURQUOISE},
	['S']  = {'SELECT',            _TURQUOISE},
	[''] = {'SELECT',            _TURQUOISE},
	['t']  = {'TERMINAL',          _ORANGE},
	['v']  = {'VISUAL',            _BLUE},
	['V']  = {'VISUAL LINE',       _BLUE},
	[''] = {'VISUAL BLOCK',      _BLUE},
	['!']  = {'SHELL',             _YELLOW},

	-- libmodal
	['STAFF'] = {'STAFF', _YELLOW},
	['SCORE'] = {'SCORE', _RED}
} -- }}}

local _LEFT_SEPARATOR = ''
local _RIGHT_SEPARATOR = ''


--[[/* HELPERS */]]

--- @return boolean is_not_empty
local function buffer_not_empty()
	return vim.api.nvim_buf_line_count(0) > 1 or #vim.api.nvim_buf_get_lines(0, 0, 1, true) > 0
end

--- @return boolean wide_enough
local function checkwidth()
	return (vim.api.nvim_win_get_width(0) / 2) > 40
end

--- Set buffer variables for file icon and color.
-- local function set_devicons()
-- 	local icon, color = require('nvim-web-devicons').get_icon(vim.fn.expand '%:t', vim.fn.expand '%:e', {default = true})
-- 	vim.b.file_icon = icon
-- 	vim.b.file_color = string.format('#%06x', vim.api.nvim_get_hl_by_name(color, true).foreground)
-- end

--- @return string color
-- local function file_color()
	-- if not vim.b.file_color then set_devicons() end
	-- return vim.b.file_color
-- end

--- @return string icon
-- local function file_icon()
	-- if not vim.b.file_icon then set_devicons() end

	-- return vim.b.file_icon
-- end

-- vim.cmd 'hi clear FelineViMode'

--[[/* FELINE CONFIG */]]

require('feline').setup(
{
	colors = {bg = _MIDBAR[1]},
	components =
	{ -- {{{
		active =
		{
			{ -- Left {{{
				{
					icon = '▊ ',
                    provider = function() -- auto change color according the vim mode
						-- local mode_color
						local mode_name

                        if vim.g.libmodalActiveModeName then
							mode_name = vim.g.libmodalActiveModeName
							-- mode_color = _MODES[mode_name]
							-- mode_color = vi_mode_colors[mode_name]
						elseif vim.g.libmodalLayerActive == 1 then
							mode_name = "SCORE"
							-- mode_color = vi_mode_colors[mode_name]
							-- mode_color = _MODES[mode_name]
						else
							local current_mode = _MODES[vim.api.nvim_get_mode().mode]
							if not current_mode then
                                current_mode = "error"
                        end
                        mode_name = current_mode[1]
                        -- mode_color = current_mode[2]
                    end
                        return mode_name..' '
                    end,
                    hl = function()
						local mode_color = vim.g.libmodalLayerActive==1 and _MODES['SCORE'][2][1] or _MODES[vim.api.nvim_get_mode().mode][2][1]
                        return {
                            fg = "black",
                            bg = mode_color,
                            style = "bold"
                        }
                    end,
                    right_sep = function() return
                        {
                            hl = {
                                fg = _SIDEBAR[1],
                                -- bg = file_color()
                                -- bg = '#ffffff'
                                }, str = ' ',
                                -- }, str = _RIGHT_SEPARATOR,
                        }
                        end,
                },
               {
                    -- provider = 'git_branch',
					-- icon = '  ',
                    -- hl = function() return {
                    --                 fg = _SIDEBAR[1],
                    --                 bg = '#ffffff'
                    --             } end,
                    -- provider  = function() return ' '..file_icon()..' ' end,
                    -- git_branch here
                    -- provider  = function() return ' helleo'..' ' end,
                    right_sep = function() return
                            {
                                hl = {
                                    fg = _SIDEBAR[1],
                                    -- bg = file_color()
                                -- bg = '#ffffff'
                                },
                                        -- str = _LEFT_SEPARATOR,
                            }
                        end,
                    },
                    {
                        colored_icon = false,
                        enabled = buffer_not_empty,
                        -- file_modified_icon = ' ﬀ  ',

					hl = {
                                    fg = _TEXT[1],
                                    bg = _SIDEBAR[1],
                                    style = 'bold'
                                },
					icon = '',
                    provider  = {
                        name = 'file_info',
                        opts = {
                        type = 'unique',
                      -- HERE, THIS IS WHERE YOU CHANGE THE ICON FOR FILE CHANGES!!
                        file_modified_icon = FMI_SET(),
                        }
                    },
                    -- provider = function(file_info)
                    -- end,
                    right_sep = {
						hl = {bg = _SIDEBAR[1]},
						str = ' ',
					},
					type = 'relative-short',
				},

				{
					enabled = buffer_not_empty,
					hl = {fg = _TEXT[1], bg = _SIDEBAR[1], style = 'bold'},
					provider  = 'file_size',
					right_sep =
					{
						hl = {bg = _SIDEBAR[1]},
						str = ' ',
					},
				},

				{
					hl = {fg = _SIDEBAR[1], bg = _GREEN_DARK[1], style = 'bold'},
					icon = '  ',

					{
						always_visible = true,
						hl = {fg = _SIDEBAR[1], bg = _BLACK[1]},
						str = _RIGHT_SEPARATOR,
					},
					provider = 'git_branch',
				},

				{
					hl = {bg = _MIDBAR[1]},
					left_sep =
					{
						always_visible = true,
						hl = {fg = _MIDBAR[1], bg = _GREEN_DARK[1]},
						str = ' '.._LEFT_SEPARATOR,
						-- str = ' '.._RIGHT_SEPARATOR,
						-- str = '',
					},
					provider = '',
				},

				{
					enabled = checkwidth,
					hl = {fg = _GREEN_LIGHT[1], bg = _MIDBAR[1]},
					icon = '+',
					provider = 'git_diff_added',
				},

				{
					enabled = checkwidth,
					hl = {fg = _ORANGE_LIGHT[1], bg = _MIDBAR[1]},
					icon = '~',
					provider = 'git_diff_changed',
				},
				{
					enabled = checkwidth,
					hl = {fg = _RED_LIGHT[1], bg = _MIDBAR[1]},
					icon = '-',
					provider = 'git_diff_removed',
				},

				{
					hl = {fg = _RED[1], bg = _MIDBAR[1]},
					icon = ' Ⓧ ',
					provider = 'diagnostic_errors',
				},

				{
					hl = {fg = _YELLOW[1], bg = _MIDBAR[1]},
					icon = ' ⚠️ ',
					provider = 'diagnostic_warnings',
				},

				{
					hl = {fg = _MAGENTA[1], bg = _MIDBAR[1]},
					icon = '💡',
					provider = 'diagnostic_hints',
				},

				{
					hl = {fg = _WHITE[1], bg = _MIDBAR[1]},
					icon = ' ⓘ ',
					provider = 'diagnostic_info',
				},
			}, -- }}}

			{{ -- Middle {{{
				enabled = function() return checkwidth() and vim.lsp.buf.server_ready() end,
				hl = {fg = _ICE[1], bg = _MIDBAR[1]},
				icon = ' ',
				provider = function() return vim.b.vista_nearest_method_or_function or '' end,
			}}, -- }}}

			{ -- Right {{{
				{
					hl = {fg = _TEXT[1], bg = _SIDEBAR[1]},
					left_sep =
					{
						hl = {fg = _MIDBAR[1], bg = _SIDEBAR[1]},
						str = _RIGHT_SEPARATOR..' ',
					},
					provider = 'file_encoding',
					right_sep =
					{
						hl = {bg = _SIDEBAR[1]},
						str = ' ',
					},
				},

				{
					hl = function() return {
                                    fg = _BLACK[1],
                                    -- bg = file_color(),
                                    style = 'bold'
                                } end,
					left_sep = function() return
						{
							hl = {
                                -- fg = file_color(),
                                bg = _SIDEBAR[1]
                            },
							-- str = _LEFT_SEPARATOR,
						}
					end,
					provider = 'file_type',
					right_sep = function() return
						{
							hl = {
                                -- fg = file_color(),
                                bg = _SIDEBAR[1]
                            },
							-- str = _RIGHT_SEPARATOR..' ',
						}
					end,
				},

				{
					enabled = buffer_not_empty,
					hl = {fg = _TEXT[1], bg = _SIDEBAR[1]},
					provider = function()
						return ' ┫'..(vim.api.nvim_win_get_cursor(0)[2] + 1)
					end,
				},
				{
					hl = {fg = _WHITE[1], bg = _TURQUOISE[1]},
					left_sep =
                                    -- hl = {bg = _TURQUOISE[1]},
					{
						hl = {fg = _TURQUOISE[1], bg = _SIDEBAR[1]},
						str = ' '.._LEFT_SEPARATOR,
					},
					provider = 'line_percentage',
					right_sep =
					{
						hl = {bg = _TURQUOISE[1]},
						str = ' ',
					},
				},

				{
					hl = {fg = _BLACK[1], bg = _TURQUOISE[1]},
					provider = 'scroll_bar',
				},
			}, -- }}}
		},
		inactive =
		{
			{ -- Left {{{
				{
					hl = {fg = _GRAY[1], bg = _BLACK[1], style = 'bold'},
					left_sep =
					{
						hl = {bg = _RUST[1]},
						str = ' ',
					},
					provider = 'file_type',
				},
				{
					hl = {bg = _RUST[1]},
					provider = ' ',
					right_sep =
					{
						hl = {fg = _GRAY[1], bg = _GRAY_DARK[1]},
						str = _RIGHT_SEPARATOR,
					},
				},
			}, -- }}}

			{{ -- Right {{{
				hl = {fg = _BLACK[1], bg = _PURPLE[1], style = 'bold'},
				left_sep =
				{
					hl = {fg = _PURPLE[1], bg = _MIDBAR[1]},
					str = _LEFT_SEPARATOR,
				},
				provider = function(_, win_id) return _BUF_ICON[vim.bo[vim.api.nvim_win_get_buf(win_id or 0)].filetype] or '' end,
			}}, -- }}}
		},
	}, -- }}}
	force_inactive =
	{ -- {{{
		bufnames = {},
		buftypes = {'help', 'prompt', 'terminal'},
		filetypes =
		{
			'dbui',
			'diff',
			'help',
			'NvimTree',
			'packer',
			'qf',
			'undotree',
			'vista',
			'vista_kind',
			'vista_markdown',
		},
	}, -- }}}
})
return {
    FMI_SET = FMI_SET,
}