-- BARBAR
vim.g.bufferline = {
  -- Enable/disable animations
  animation = false,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  -- tabpages = true,

  -- Enable/disable close button
  -- closable = true,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = false,

  -- Excludes buffers from the tabline

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
  icons = false,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  -- icon_custom_colors = true,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab_modified = '●',
  icon_close_tab = '',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = false,

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,

    -- fg_target = 'red',

    -- fg_current  = fg(['Normal'], '#efefef'),
    -- fg_visible  = fg(['TabLineSel'], '#efefef'),
    -- fg_inactive = fg(['TabLineFill'], '#888888'),
    -- fg_modified  = fg(['WarningMsg'], '#E5AB0E'),
    -- fg_special  = fg(['Special'], '#599eff'),
    -- fg_subtle  = fg(['NonText', 'Comment'], '#555555'),
    -- bg_current  = bg(['Normal'], '#000000'),
    -- bg_visible  = bg(['TabLineSel', 'Normal'], '#000000'),
    -- bg_inactive = bg(['TabLineFill', 'StatusLine'], '#000000')
}