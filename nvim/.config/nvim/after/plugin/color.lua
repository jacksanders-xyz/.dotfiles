function ColorMyPencils()
    vim.g['airline#extensions#tabline#enabled'] = 1
    -- vim.g.airline_theme = 'base16_gruvbox_dark_pale'
    -- vim.g.airline_theme = 'base16_harmonic_dark'
    vim.g.airline_theme = 'angr'
    require('colorbuddy').colorscheme('gruvbuddy')
    vim.g.gruvbox_contrast_dark = 'hard'
    vim.g['airline#extensions#tabline#left_sep'] = ' '
    vim.g['airline#extensions#tabline#left_alt_sep'] = '|'
    vim.opt.laststatus=3
    vim.api.nvim_set_hl(0, "WinSeparator", {bg='NONE'})
end
ColorMyPencils()
