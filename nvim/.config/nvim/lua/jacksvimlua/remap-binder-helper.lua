-- THIS IS A LITTLE MODULE THAT SIMPLIFIES REMAPING, 
-- SO THAT YOU DON'T HAVE TO WRITE THE FULL THING WITH THE OBJECT
-- IT GETS CALLED FIRST, BEFORE OUR ACTUAL KEYMAPS
local M = {}
local function bind(op, outer_opts)
    --- IF WE DON'T PASS BIND AN OUTER OPTION, DEFAULT IT TO NOREMAP=TRUE
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.nmap = bind("n", {noremap = false})
-- nmap is a recursive
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

return M
