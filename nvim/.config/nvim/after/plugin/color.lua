require("tokyonight").setup({
    style = "moon",
    terminal_colors = true,
    transparent = true, -- Enable this to disable setting the background color
    on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
            bg = prompt,
        }
        hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
        }
        hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
        }
    end,
    on_colors = function(colors)
    end,
})

function ColorMyPencils()
    vim.cmd("colorscheme tokyonight")
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.opt.laststatus=3
    vim.api.nvim_set_hl(0, "WinSeparator", {bg='NONE'})
end
ColorMyPencils()
