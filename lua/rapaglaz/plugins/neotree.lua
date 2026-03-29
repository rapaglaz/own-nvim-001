return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x", -- stable branch
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.icons", -- icons
      "MunifTanjim/nui.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        source_selector = { winbar = true }, -- quick source switching
        use_system_clipboard = true,
        sort_case_insensitive = true,
        default_component_configs = {
          indent = {
            with_markers = true,
            indent_size = 3,
          },
          git_status = {
            symbols = {
              added     = "✚",
              modified  = "✎",
              deleted   = "✖",
              renamed   = "➜",
              untracked = "★",
              ignored   = "◌",
              unstaged  = "✗",
              staged    = "✓",
              conflict  = "",
            },
          },
        },
        window = {
          position = "float",
          mappings = {
            -- navigate to parent directory
            ["-"] = "navigate_up",
          },
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { ".DS_Store", "thumbs.db" },
          },
        },
      })

      -- Return VCS root (via .git search) or current file's directory.
      local function get_root()
        local file = vim.fn.expand("%:p")
        if file == "" then
          return vim.fn.getcwd()
        end
        local dir = vim.fn.fnamemodify(file, ":h")
        -- Search upward for .git - also handles worktrees via .git file)
        local git_dir = vim.fn.finddir(".git", dir .. ";")
        if git_dir ~= "" then
          return vim.fn.fnamemodify(git_dir, ":h:p")
        end
        return dir
      end

      -- \e[24;2~ is the standard xterm/VT220 sequence for S-F12.
      vim.cmd([[
        if !has('gui_running')
          execute "set <S-F12>=\<Esc>[24;2~"
        endif
      ]])

      local function toggle_float()
        local root = get_root()
        vim.cmd("Neotree float toggle reveal dir=" .. vim.fn.fnameescape(root))
      end

      local function toggle_right()
        local root = get_root()
        vim.cmd("Neotree right toggle reveal dir=" .. vim.fn.fnameescape(root))
      end

      -- F12: toggle NeoTree as float (smart root)
      vim.keymap.set("n", "<F12>", toggle_float, { desc = "Toggle NeoTree float (smart root)" })

      -- <F24> is an alias some terminals (e.g. kitty) use for S-F12.
      vim.keymap.set("n", "<S-F12>", toggle_right, { desc = "Toggle NeoTree right panel (smart root)" })
      vim.keymap.set("n", "<F24>", toggle_right, { desc = "Toggle NeoTree right panel (smart root)" })
    end,
  },
}
