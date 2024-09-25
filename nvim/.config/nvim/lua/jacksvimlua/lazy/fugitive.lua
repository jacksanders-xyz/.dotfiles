return {
    "tpope/vim-fugitive",
    config = function()

        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local Jacks_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd

        autocmd("BufWinEnter", {
            group = Jacks_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- rebase always
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull',  '--rebase'})
                end, opts)

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>tp", ":Git push -u origin ", opts);
            end,
        })

        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")

        vim.keymap.set("n","<leader>gl", ":Gclog<CR>")
        vim.keymap.set("n","<leader>ga", ":Git add %:p<CR><CR>")
        vim.keymap.set("n","<leader>gp", ":Git push<CR>")
        vim.keymap.set("n","<leader>gum", ":Git push --set-upstream origin mybranch")
        vim.keymap.set("n","<leader>gfa", ":Git fetch --all<CR>")
        vim.keymap.set("n","<leader>gfp", ":Git fetch --prune<CR>")
        vim.keymap.set("n","<leader>grum", ":Git rebase upstream/master<CR>")
        vim.keymap.set("n","<leader>grom", ":Git rebase origin/master<CR>")
        vim.keymap.set("n","<leader>gm", ":Git merge mybranch")


        vim.keymap.set("n","<leader>gdrb", ":Git push -d origin mybranch")
        vim.keymap.set("n","<leader>gd", ":Git diff<CR>")
        vim.keymap.set("n","<leader>gc", ":Git commit -v -q<CR>")

        -- Commits current file
        vim.keymap.set("n","<leader>gg", ":Git commit -v -q %:p<CR> ")
        vim.g.github_enterprise_urls={'https://github.ibm.com'}
    end
}

