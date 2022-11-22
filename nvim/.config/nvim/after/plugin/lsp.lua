local Remap = require("jacksvimlua.remap-binder-helper")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local sumneko_root_path = "~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

-- LSP INSTALLER
local lsp_installer = require("nvim-lsp-installer")
require("nvim-lsp-installer").setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- NVIM CMP
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
}

local lspkind = require("lspkind")
cmp.setup({
    snippet = {
        expand = function(args)
            -- For `ultisnips` user.
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. " " .. menu
                end
                vim_item.kind = ""
            end
            vim_item.menu = menu
            return vim_item
        end,
    },
    sources = {
        { name = "cmp_tabnine" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = 'orgmode' },
        { name = 'ultisnips' },
    },
})

-- TAB NINE
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

-- LSP KEYMAPS
local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("gi", function() vim.lsp.buf.implementation() end)
			nnoremap("K", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
			nnoremap("[d", function() vim.diagnostic.goto_next() end)
			nnoremap("]d", function() vim.diagnostic.goto_prev() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
			-- inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
		end,
	}, _config or {})
end

-- LSP CONFIG
-- LSP LANGUAGE SERVERS
require'lspconfig'.tsserver.setup(config())
require'lspconfig'.sumneko_lua.setup(config({
-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}))

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))
require'lspconfig'.lemminx.setup(config({
    filetypes = {"xml", "xsd", "xsl", "xslt", "svg"}
}))
require'lspconfig'.dockerls.setup(config())
require'lspconfig'.yamlls.setup(config())
require'lspconfig'.vimls.setup(config())
require'lspconfig'.vuels.setup(config())
require'lspconfig'.jsonls.setup(config())
require'lspconfig'.bashls.setup(config())
