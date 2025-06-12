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
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
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
    end,
  },
}
