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
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
      },
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          path_display = { "smart" },
          dynamic_preview_title = true,
          winblend = 0,
          file_sorter = require("telescope.sorters").get_fzy_sorter,
          generic_sorter = require("telescope.sorters").get_fzy_sorter,
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--hidden",
            "--glob=!.git",
          },
          preview = {
            treesitter = true,
            timeout = 150,
          },
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
        extensions = {
          frecency = {
            enable_prompt_mappings = true,
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("frecency")

      -- Set bright titles for Telescope windows
      vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#c2cbeb", bold = true })
      vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#c2cbeb", bold = true })
      vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#c2cbeb", bold = true })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>pf", function()
        local buf_dir = vim.fn.expand("%:p:h")
        local ok = pcall(builtin.git_files, {
          cwd = buf_dir,
          show_untracked = true,
        })
        if not ok then
          builtin.find_files({ cwd = buf_dir })
        end
      end, { desc = "Find files (in buffer dir)" })
      vim.keymap.set("n", "<leader>pF", function()
        telescope.extensions.frecency.frecency({
          workspace = "CWD",
        })
      end, { desc = "Find files (frecency)" })
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
      vim.keymap.set("n", "<leader>pws", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end, { desc = "Grep word under cursor" })
      vim.keymap.set("n", "<leader>pWs", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end, { desc = "Grep WORD under cursor" })
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Grep search" })
      vim.keymap.set(
        "n",
        "<leader>pg",
        telescope.extensions.live_grep_args.live_grep_args,
        { desc = "Live Grep (args)" }
      )
      vim.keymap.set("n", "<leader>pr", builtin.resume, { desc = "Resume last picker" })
      vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
    end,
  },
}
