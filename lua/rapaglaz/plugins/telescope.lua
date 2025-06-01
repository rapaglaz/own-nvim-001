return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          dynamic_preview_title = true,
          winblend = 0, -- Changed from q0 to 0 (fully opaque) - adjust between 0-100 as needed
          -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          ignore_patterns = { "node_modules", ".git/" },
        },
        layout_config = {
          vertical = { width = 0.7 },
          -- other layout configuration here
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false,
          },
          grep_string = {
            theme = "dropdown",
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
      vim.keymap.set("n", "<C-p>", builtin.git_files, {})
      vim.keymap.set("n", "<leader>pws", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>pWs", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.keymap.set(
        "n",
        "<leader>pg",
        telescope.extensions.live_grep_args.live_grep_args,
        { desc = "Live Grep (args)" }
      )
      vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
  },
}
