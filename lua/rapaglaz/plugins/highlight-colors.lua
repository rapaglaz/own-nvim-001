return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  -- ft = { "css", "scss", "html", "javascript", "typescript", "jsx", "tsx", "vue", "svelte", "lua", "vim", "conf" },
  cmd = { "HighlightColors" },
  config = function()
    require("nvim-highlight-colors").setup({
      -- Render style (background, foreground, virtual)
      render = "virtual", -- or 'foreground' or 'virtual'

      -- Virtual text configuration (when render = 'virtual')
      virtual_symbol = "■",
      virtual_symbol_prefix = "",
      virtual_symbol_suffix = " ",

      -- Enable for different color formats
      enable_hex = true,          -- #RRGGBB
      enable_short_hex = true,    -- #RGB
      enable_rgb = true,          -- rgb(255, 255, 255)
      enable_hsl = true,          -- hsl(360, 100%, 100%)
      enable_var_usage = true,    -- CSS variables var(--color)
      enable_named_colors = true, -- red, blue, etc.
      enable_tailwind = true,     -- Tailwind CSS classes

      -- Tailwind CSS configuration
      tailwind = {
        enable = true,
        -- When true, only show colors for Tailwind classes
        only_css_colors = false,
        -- CSS file to use for Tailwind colors (optional)
        css_file = nil,
      },

      -- File type specific settings
      custom_colors = {
        -- Add custom color patterns here if needed
      },

      -- Exclude patterns (regex)
      exclude_filetypes = {},
      exclude_buftypes = {
        "terminal",
        "nofile",
      },

      -- Performance settings
      debounce_time = 100, -- Milliseconds to debounce highlighting
    })

    -- Create user commands for easy control
    vim.api.nvim_create_user_command("HighlightColorToggle", function()
      require("nvim-highlight-colors").toggle()
    end, { desc = "Toggle color highlighting for current buffer" })

    vim.api.nvim_create_user_command("HighlightColorOn", function()
      require("nvim-highlight-colors").turnOn()
    end, { desc = "Enable color highlighting for current buffer" })

    vim.api.nvim_create_user_command("HighlightColorOff", function()
      require("nvim-highlight-colors").turnOff()
    end, { desc = "Disable color highlighting for current buffer" })

    -- Keymaps for quick toggle
    vim.keymap.set("n", "<leader>cc", function()
      require("nvim-highlight-colors").toggle()
    end, { desc = "Toggle color highlighting" })
  end,
}
