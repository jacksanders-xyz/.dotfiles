local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
     highlight_hovered_item = true,
  }
   if server.name == "sumneko_lua" then
      local sumneko_opts = {
        settings = {
          Lua = {
            runtime = { -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- -- Setup your lua path
            path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
              },
            },
          },
        },
      }
      opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    server:setup(opts)
end)
