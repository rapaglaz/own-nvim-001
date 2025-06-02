return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- stable branch
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- icons
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        auto_focus = true,
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_size = 2,
          },
        },
        window = {
          position = "right", -- display on the right
          width = 36,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })

      -- Map F12 to toggle NeoTree panel
      vim.keymap.set("n", "<F12>", "<cmd>Neotree toggle<CR>", { desc = "Toggle NeoTree (right panel)" })
    end,
  },
}
