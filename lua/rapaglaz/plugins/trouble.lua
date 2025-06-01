return {
  {
    "folke/trouble.nvim",
    config = function()
      local trouble = require("trouble")
      trouble.setup({
        icons = false,
        use_diagnostic_signs = true, -- Use Neovim diagnostic signs
        auto_open = false, -- Do not auto-open Trouble
        auto_close = true, -- Auto-close when no diagnostics
        auto_preview = true, -- Preview location automatically
        mode = "workspace_diagnostics", -- Default mode
        group = true, -- Group results by file
        padding = true, -- Add padding to window
        cycle_results = true, -- Cycle item navigation
      })

      -- Keymaps with descriptions for which-key integration
      vim.keymap.set("n", "<leader>tt", function()
        trouble.toggle()
      end, { desc = "Toggle Trouble" })

      vim.keymap.set("n", "<leader>td", function()
        trouble.toggle("document_diagnostics")
      end, { desc = "Trouble Document Diagnostics" })

      vim.keymap.set("n", "<leader>tw", function()
        trouble.toggle("workspace_diagnostics")
      end, { desc = "Trouble Workspace Diagnostics" })

      vim.keymap.set("n", "<leader>tq", function()
        trouble.toggle("quickfix")
      end, { desc = "Trouble Quickfix" })

      vim.keymap.set("n", "<leader>tl", function()
        trouble.toggle("loclist")
      end, { desc = "Trouble Location List" })

      vim.keymap.set("n", "<leader>tr", function()
        trouble.toggle("lsp_references")
      end, { desc = "Trouble LSP References" })

      vim.keymap.set("n", "[t", function()
        trouble.next({ skip_groups = true, jump = true })
      end, { desc = "Next Trouble Item" })

      vim.keymap.set("n", "]t", function()
        trouble.previous({ skip_groups = true, jump = true })
      end, { desc = "Previous Trouble Item" })
    end,
  },
}
