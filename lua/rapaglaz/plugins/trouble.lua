-- Trouble.nvim v3 API
-- v2 API (toggle("document_diagnostics"), use_diagnostic_signs, etc.) was removed.
-- v3 uses mode-based config and open/toggle({ mode = "..." }) calls.
return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      -- v3 options
      auto_close = true,   -- close when no items remain
      auto_preview = true, -- preview location under cursor
      focus = false,       -- don't steal focus on open
      restore = true,      -- restore last mode on re-open
      follow = true,       -- follow current item in the list
      modes = {
        diagnostics = {
          auto_open = false,
        },
      },
      icons = {
        indent        = {
          fold_open  = " ",
          fold_close = " ",
        },
        folder_closed = " ",
        folder_open   = " ",
        kinds         = vim.g.trouble_lsp_icons or {},
      },
      win = {
        size = { height = 10 },
      },
    },
    keys = {
      { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>",                                       desc = "Trouble: Workspace Diagnostics" },
      { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                          desc = "Trouble: Document Diagnostics" },
      { "<leader>tw", "<cmd>Trouble diagnostics toggle<cr>",                                       desc = "Trouble: Workspace Diagnostics" },
      { "<leader>tq", "<cmd>Trouble qflist toggle<cr>",                                            desc = "Trouble: Quickfix" },
      { "<leader>tl", "<cmd>Trouble loclist toggle<cr>",                                           desc = "Trouble: Location List" },
      { "<leader>tr", "<cmd>Trouble lsp_references toggle<cr>",                                    desc = "Trouble: LSP References" },
      { "]t",         function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next Trouble Item" },
      { "[t",         function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous Trouble Item" },
    },
  },
}
