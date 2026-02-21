return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      { "<C-'>",      desc = "Toggle terminal",       mode = { "n", "i", "t" } },
      { "<C-;>",      desc = "Toggle float terminal", mode = { "n", "i", "t" } },
      { "<C-D-M-;>",  desc = "Kill all terminals",    mode = { "n", "i", "t" } },
      { "<leader>TT", desc = "Toggle all terminals" },
      { "<leader>Tn", desc = "Next terminal",         mode = { "n", "t" } },
      { "<leader>Tp", desc = "Previous terminal",     mode = { "n", "t" } },
    },
    config = function()
      require("toggleterm").setup({
        size = function(term)
          local height = vim.o.lines - vim.o.cmdheight
          return math.floor(height * 0.4) -- 2/5 of the editor height
        end,
        -- open_mapping handled manually below
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = false,
        direction = "horizontal",
        float_opts = {
          border = "curved",
          winblend = 0,
        },
        highlights = {
          FloatBorder = { link = "FloatBorder" },
        },
        shell = "zsh",
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local function buf_dir()
        local dir = vim.fn.expand("%:p:h")
        if dir == "" or vim.fn.isdirectory(dir) == 0 then
          dir = vim.fn.getcwd()
        end
        return dir
      end

      -- Horizontal terminal — single instance, opens in current buffer's dir
      local horiz_term = nil
      vim.keymap.set({ "n", "i", "t" }, "<C-'>", function()
        if horiz_term == nil then
          horiz_term = Terminal:new({ direction = "horizontal", dir = buf_dir() })
        end
        horiz_term:toggle()
      end, { desc = "Toggle terminal (Ctrl+')" })

      -- Float terminal — single instance, opens in current buffer's dir
      local float_term = nil
      vim.keymap.set({ "n", "i", "t" }, "<C-;>", function()
        if float_term == nil then
          float_term = Terminal:new({ direction = "float", dir = buf_dir() })
        end
        float_term:toggle()
      end, { desc = "Toggle float terminal (Ctrl+;)" })

      -- Kill all terminals — resets instances so next open uses current buffer's dir
      vim.keymap.set({ "n", "i", "t" }, "<C-D-M-;>", function()
        if horiz_term then
          horiz_term:shutdown()
          horiz_term = nil
        end
        if float_term then
          float_term:shutdown()
          float_term = nil
        end
      end, { desc = "Kill all terminals" })

      -- Toggle all terminals
      vim.keymap.set("n", "<leader>TT", function()
        require("toggleterm").toggle_all()
      end, { desc = "Toggle all terminals" })

      -- ToggleTerm navigation
      vim.keymap.set({ "n", "t" }, "<leader>Tn", function()
        require("toggleterm").next_terminal()
      end, { desc = "Next terminal" })

      vim.keymap.set({ "n", "t" }, "<leader>Tp", function()
        require("toggleterm").prev_terminal()
      end, { desc = "Previous terminal" })

      -- Neovim tab switching: Ctrl+Arrow Right/Left
      vim.keymap.set({ "n", "t" }, "<C-Right>", ":tabnext<CR>", { desc = "Next tab" })
      vim.keymap.set({ "n", "t" }, "<C-Left>", ":tabprevious<CR>", { desc = "Previous tab" })
    end,
  },
}
