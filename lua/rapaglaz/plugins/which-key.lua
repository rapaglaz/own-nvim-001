return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          spelling = { enabled = true },
        },
        win = {
          border = "rounded",
        },
        layout = {
          align = "center",
        },
        icons = {
          mappings = false,
        },
      })

      -- Load centralized group definitions
      wk.add(require("rapaglaz.which-key-groups"))
    end,
  },
}
