return {
    "chentoast/marks.nvim",
    config = function()
        require'marks'.setup {
            default_mappings = true,
            mappings = {
                next = "m]",
                prev =  "m[",
                delete_buf = "<C-\\>"
            }
        }
    end
}
