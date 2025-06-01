return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "│" },
          untracked = { text = "┆" },
        },
        current_line_blame = true, -- show blame
        current_line_blame_opts = {
          delay = 300,
          virt_text_pos = "eol",
        },
        signcolumn = true, -- always show signcolumn
        numhl = false, -- do not highlight line numbers
        word_diff = false, -- do not show word diff by default
        attach_to_untracked = true, -- show signs for untracked files
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk)
          map("n", "<leader>hr", gs.reset_hunk)
          map("n", "<leader>hp", gs.preview_hunk)
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end)
        end,
      })
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#81b88b", bg = "NONE" }, { force = true })
          vim.api.nvim_set_hl(
            0,
            "GitSignsChange",
            { fg = "#e2c08d", bg = "NONE" },
            { force = true }
          )
          vim.api.nvim_set_hl(
            0,
            "GitSignsDelete",
            { fg = "#c74e39", bg = "NONE" },
            { force = true }
          )
          vim.api.nvim_set_hl(
            0,
            "GitSignsCurrentLineBlame",
            { fg = "#5c6370", italic = true },
            { force = true }
          )
        end,
      })
    end,
  },
}
