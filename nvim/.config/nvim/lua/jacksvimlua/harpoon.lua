require("harpoon").setup({
    nav_first_in_list = true,
})

-- if you have some terminal commands you want to preconfigure, you can put them in the projects var. Prime has this:
-- projects = {
--   ["/home/theprimeagen/work/nrdp/backport-2"] = {
--     term = {
--       cmds = {
--         "ninja -C /home/theprimeagen/work/nrdp/builds/backport-2 -j 25 && cp compile_commands.json /home/theprimeagen/work/nrdp/backport-2\n",
--       }
--     }
--   }
-- }
