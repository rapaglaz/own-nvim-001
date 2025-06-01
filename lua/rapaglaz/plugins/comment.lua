return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function()
      require("Comment").setup({
        -- Add a space b/w comment and the line
        padding = true,
        -- Whether the cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while (un)comment
        ignore = "^(%s*)$",

        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          line = "gcc", -- Line-comment toggle keymap
          block = "gbc", -- Block-comment toggle keymap
        },

        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          line = "gc", -- Line-comment keymap
          block = "gb", -- Block-comment keymap
        },

        -- LHS of extra mappings
        extra = {
          above = "gcO", -- Add comment on the line above
          below = "gco", -- Add comment on the line below
          eol = "gcA", -- Add comment at the end of line
        },

        -- Enable keybindings
        mappings = {
          basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
        },
      })
    end,
  },

  -- Only load ts-context-commentstring for specific filetypes
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    ft = { "typescriptreact", "javascriptreact", "vue", "svelte" },
    config = function()
      require("ts_context_commentstring").setup({
        enable_autocmd = false, -- Disable autocmd, we handle it manually
        -- languages = {
        --   typescript = "// %s",
        --   css = "/* %s */",
        --   scss = "/* %s */",
        --   html = "<!-- %s -->",
        --   svelte = "<!-- %s -->",
        --   vue = "<!-- %s -->",
        --   json = "",
        -- },
      })
    end,
  },
}
