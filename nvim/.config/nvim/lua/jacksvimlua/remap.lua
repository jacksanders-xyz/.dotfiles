-- LEADER
vim.g.mapleader = " "
vim.keymap.set("i", "<C-c>", "<Esc>")

-- SCROLL
vim.keymap.set("n", "<C-E>", "jzz")
vim.keymap.set("n", "<C-Y>", "kzz")

--JUMP CENTER
-- vim.keymap.set('n',"<C-o>", '<C-o>zz')
-- vim.keymap.set('n',"<C-i>", '<C-i>zz')

vim.keymap.set("n", "'h", "'hzz")
vim.keymap.set("n", "'t", "'tzz")
vim.keymap.set("n", "'n", "'nzz")
vim.keymap.set("n", "'s", "'szz")

-- EASIER SEARCH AND REPLACE
vim.keymap.set("n", "<leader>fr", ":%s/")
vim.keymap.set("v", "<leader>fr", " :s/", { noremap = true, silent = false })

-- ZEN
vim.keymap.set("n", "<leader>m", ":NoNeckPain<CR>")
vim.keymap.set("n", "<leader>M", ":NoNeckPainToggleRightSide<CR>")

-- MAXIMIZER FOR VIMSPECTOR
-- vim.keymap.set('n' ,"<leader>,", "<cmd>MaximizerToggle!<CR>")
vim.api.nvim_set_keymap(
	"n",
	"<leader>,",
	":lua require('jacksvimlua.maximizer').toggle()<CR>",
	{ noremap = true, silent = true }
)

-- BUFFER MANAGEMENT
vim.keymap.set("n", "<leader>x", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>X", "<cmd>bd!<CR>")
vim.keymap.set("n", "<leader>n", "<cmd>bn!<CR>")
vim.keymap.set("n", "<leader>N", "<cmd>bN!<CR>")

-- Repeat last ex command
vim.keymap.set("n", "<leader>.", "@:")

-- YANK/PUT FROM/TO CLIPBOARD
vim.keymap.set("v", "<leader>y", '"*y')
vim.keymap.set("n", "<leader>p", '"*P')
vim.keymap.set("v", "<leader>p", '"*P')
vim.keymap.set("i", "<c-p>", '<ESC>*Pi"')

-- MAKE Y BEHAVE LIKE ALL THE OTHER CAPITAL LETTERS
vim.keymap.set("n", "Y", "y$")

-- CENTER
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- SPELLCHECK TOGGLE IS <F4>
vim.keymap.set("n", "<leader>S", ':setlocal spell! spelllang=en_us<CR>"')

-- MOVING TEXT AROUND
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("n", "]e", "I<CR><ESC>==")

-- NETRW
-- vim.keymap.set('n' ,"<leader>is", "<C-w><C-v>:Ex<CR>")
-- vim.keymap.set('n' ,"<leader>iv", ":Ex<CR>")
vim.keymap.set("n", "<leader>is", "<C-w><C-v>:Oil<CR>", { silent = true })
vim.keymap.set("n", "<leader>iv", ":Oil<CR>", { silent = true })

-- UNDOTREE
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>")

-- REMAP W to :w
vim.api.nvim_create_user_command("W", "write", {})

-- W3 & TIMECARDS
vim.api.nvim_create_user_command("W3", "!open https://w3.ibm.com", {})
vim.api.nvim_create_user_command("TC", "!open https://ibmsc.lightning.force.com/lightning/page/home", {})
vim.api.nvim_create_user_command("TZ", "!open https://techzone.ibm.com/home", {})

-- FORMAT YERSELF SOME JSON
vim.keymap.set("n", "<leader>FJ", ":%!jq '.'<CR>")

-- CONSOLE.log word
-- vim.keymap.set('n' ,"<leader>C", function()
--     local word = vim.fn.expand("<cword>")
--     local string_prep = "lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('oconsole.log("
--     string_prep = string_prep..'"the '..word..': ",'..word..")<esc>',true,false,true),'m',true)"
--     vim.api.nvim_command(string_prep)
-- end)

-- SURROUND
vim.keymap.set("n", "<leader>s", "<Plug>Ysurroundiw")

-- QF
local jacks_qf_g = 0
local jacks_qf_l = 0
local function ToggleQFList(global)
	if global == 1 then
		if jacks_qf_g == 1 then
			jacks_qf_g = 0
			vim.cmd("cclose")
		else
			jacks_qf_g = 1
			vim.cmd("copen")
		end
	else
		if jacks_qf_l == 1 then
			jacks_qf_l = 0
			vim.cmd("lclose")
		else
			jacks_qf_l = 1
			vim.cmd("lopen")
		end
	end
end
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-q>", function()
	ToggleQFList(1)
end)
vim.keymap.set("n", "<leader>q", function()
	ToggleQFList(0)
end)

vim.api.nvim_set_keymap("n", "<C-w><C-b>", "<C-W><C-q><C-w><C-p>", { noremap = true, silent = true })
