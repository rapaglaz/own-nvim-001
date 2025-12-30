return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Modern Unicode symbols for better visual appeal
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "│" },
        untracked = { text = "┆" },
      },
      -- Blame
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      attach_to_untracked = true,
      update_debounce = 100,
      status_formatter = nil,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },

      trouble = false,
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        -- Helper function for buffer-local keymaps
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.silent = opts.silent ~= false
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation between hunks
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Next git hunk" })

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Previous git hunk" })

        -- Hunk actions (normal mode)
        map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
        map("n", "<leader>gD", function()
          gitsigns.diffthis("~")
        end, { desc = "Diff this ~" })

        -- Hunk actions (visual mode)
        map("v", "<leader>gs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage selected hunk" })
        map("v", "<leader>gr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset selected hunk" })

        -- Blame
        map("n", "<leader>gb", function()
          gitsigns.blame_line({ full = true })
        end, { desc = "Git blame line" })
        map("n", "<leader>gB", function()
          gitsigns.blame_line({ full = true, ignore_whitespace = true })
        end, { desc = "Git blame line (ignore whitespace)" })
        map("n", "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle git blame" })

        -- Text objects for hunks
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select git hunk" })
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)

      -- Color scheme
      local function update_gitsigns_colors()
        local colors = {
          GitSignsAdd = { fg = "#98c379", bg = "NONE" },
          GitSignsChange = { fg = "#e5c07b", bg = "NONE" },
          GitSignsDelete = { fg = "#e06c75", bg = "NONE" },
          GitSignsAddInline = { bg = "#2d4d2d" },
          GitSignsChangeInline = { bg = "#4d3d2d" },
          GitSignsDeleteInline = { bg = "#4d2d2d" },
          GitSignsCurrentLineBlame = { fg = "#5c6370", italic = true },
          GitSignsAddLn = { bg = "#1e2c1e" },
          GitSignsChangeLn = { bg = "#2c271e" },
          GitSignsDeleteLn = { bg = "#2c1e1e" },
        }

        for group, color in pairs(colors) do
          vim.api.nvim_set_hl(0, group, color)
        end
      end

      -- Apply colors immediately
      update_gitsigns_colors()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = update_gitsigns_colors,
        desc = "Update GitSigns colors on colorscheme change",
      })
    end,
  },
}
