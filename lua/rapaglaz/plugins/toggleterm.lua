return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          local height = vim.o.lines - vim.o.cmdheight
          return math.floor(height * 0.4) -- 2/5 of the editor height
        end,
        open_mapping = [[<C-'>]],
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
        shell = "zsh",
        -- autochdir = true, -- uncomment if you want terminal to open in current file's dir
        -- highlights = { Normal = { guibg = "NONE" } }, -- customize if needed
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- Float terminal (F3)
      local float_term = Terminal:new({ direction = "float", hidden = true })
      vim.keymap.set({ "n", "t" }, "<C-;>", function()
        float_term:toggle()
      end, { desc = "Toggle float terminal (Ctrl+;)" })

      -- Toggle all terminals
      vim.keymap.set("n", "<leader>tt", function()
        require("toggleterm").toggle_all()
      end, { desc = "Toggle all terminals" })

      -- ToggleTerm navigation: cmd+alt+] / cmd+alt+[ (next/prev terminal)
      vim.keymap.set({ "n", "t" }, "<D-A-]>", function()
        require("toggleterm").next_terminal()
      end, { desc = "Next ToggleTerm" })

      vim.keymap.set({ "n", "t" }, "<D-A-[>", function()
        require("toggleterm").prev_terminal()
      end, { desc = "Previous ToggleTerm" })

      -- Neovim tab switching: Ctrl+Arrow Right/Left
      vim.keymap.set({ "n", "t" }, "<C-Right>", ":tabnext<CR>", { desc = "Next tab" })
      vim.keymap.set({ "n", "t" }, "<C-Left>", ":tabprevious<CR>", { desc = "Previous tab" })
    end,
  },
}
