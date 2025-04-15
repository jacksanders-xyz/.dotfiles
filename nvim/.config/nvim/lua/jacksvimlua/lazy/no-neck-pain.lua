return {
    {
        "shortcuts/no-neck-pain.nvim",
        config = function()
            require('no-neck-pain').setup({
                autocmds = {
                    -- enableOnTabEnter = true,
                    -- skipEnteringNoNeckPainBuffer = true,
                },
                buffers = {
                    scratchPad = {
                        enabled = true,
                        location = "~/VimWiki/ScratchPad",
                    },
                    colors = {
                        blend = 5,
                    },
                    wo = {
                        fillchars = "eob: ",
                    },
                    bo = {
                        filetype = "md",
                    },
                    right = {
                        enabled = false,
                    },
                }
            })
        end
    }
}
