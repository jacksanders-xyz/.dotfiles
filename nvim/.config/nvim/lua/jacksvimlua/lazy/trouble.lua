return {
  {
    "folke/trouble.nvim",
    config = function()
      --------------------------------------------------------------------------
      -- 1. Setup – extend the stock “symbols” filter
      --------------------------------------------------------------------------
      require("trouble").setup({
        modes = {
          symbols = {
            filter = {
              -- OR-logic across all these kinds
              any = { kind = {
                -- ⬇ original kinds
                "Class", "Constructor", "Enum", "Field", "Function",
                "Interface", "Method", "Module", "Namespace", "Package",
                "Property", "Struct", "Trait",
                -- ⬇ additions
                "Variable", "Constant", "String", "Number", "Boolean",
                "EnumMember", "TypeParameter",
              } },
            },
          },
        },
      })

      --------------------------------------------------------------------------
      -- 2. Local helpers / toggles
      --------------------------------------------------------------------------
      local trouble   = require("trouble")
      local diag_max  = false
      local sym_max   = false

      local function log(msg)
        vim.notify(msg, vim.log.levels.INFO, { title = "Trouble-toggle" })
        print("[Trouble-toggle] " .. msg)
      end

      -- Diagnostics bottom bar
      local function toggle_diagnostics()
        diag_max = not diag_max
        log("diagnostics → " .. (diag_max and "MAX" or "normal"))
        trouble.close()
        trouble.open({
          mode  = "diagnostics",
          focus = true,
          win   = {
            position     = "bottom",
            size         = diag_max and (vim.o.lines - 4) or 10,
            winfixheight = false,
          },
        })
      end

      -- Symbols sidebar
      local function toggle_symbols()
        sym_max = not sym_max
        log("symbols → " .. (sym_max and "MAX" or "normal"))
        trouble.close()
        trouble.open({
          mode  = "symbols",
          focus = true,
          win   = {
            position    = "left",
            size        = sym_max and math.floor(vim.o.columns * 0.7) or 56,
            winfixwidth = false,
          },
        })
      end

      --------------------------------------------------------------------------
      -- 3. Key-maps
      --------------------------------------------------------------------------
      -- Basics
      vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end)
      vim.keymap.set("n", "<leader>tt", function() trouble.toggle("diagnostics") end)
      vim.keymap.set("n", "<leader>tf", function()
        trouble.toggle({ mode = "symbols", focus = false, win = { position = "left", size = 56 }})
      end, { desc = "Symbols (Trouble) left" })

      -- Maximise / restore
      vim.keymap.set("n", "<leader>t,t", toggle_diagnostics,
        { desc = "Toggle maximise Trouble diagnostics" })
      vim.keymap.set("n", "<leader>t,f", toggle_symbols,
        { desc = "Toggle maximise Trouble symbols" })

      -- Navigation
      vim.keymap.set("n", "<leader>J", function()
        trouble.next({ skip_groups = true, jump = true })
      end)
      vim.keymap.set("n", "<leader>K", function()
        trouble.prev({ skip_groups = true, jump = true })
      end)

      -- Call hierarchy sidebars
      vim.keymap.set("n", "<leader>ci", function()
        trouble.toggle({
          mode = "lsp_incoming_calls",
          win  = { position = "left", size = 40 },
        })
      end, { desc = "Incoming calls (Trouble)" })

      vim.keymap.set("n", "<leader>co", function()
        trouble.toggle({
          mode = "lsp_outgoing_calls",
          win  = { position = "right", size = 40 },
        })
      end, { desc = "Outgoing calls (Trouble)" })
    end,
  },
}
