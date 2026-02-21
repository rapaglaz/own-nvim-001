return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load theme first
    lazy = false,    -- Load immediately
    config = function()
      require("catppuccin").setup({
        flavour = "auto",              -- latte, frappe, macchiato, mocha
        background = {                 -- :h background
          light = "latte",
          dark = "macchiato",          -- mocha, frappe, macchiato
        },
        transparent_background = true, -- disables setting the background color
        show_end_of_buffer = false,    -- shows the '~' characters after the end of buffers
        term_colors = false,           -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false,             -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15,           -- percentage of the shade to apply to the inactive window
        },
        no_italic = false,             -- Force no italic
        no_bold = false,               -- Force no bold
        no_underline = false,          -- Force no underline
        styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" },     -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        default_integrations = true,
        integrations = {
          alpha = true,
          indent_blankline = { enabled = true },
          cmp = true,
          gitsigns = true,
          mason = true,
          which_key = true,
          markdown = true,
          neotree = true,
          lsp_trouble = true,
          semantic_tokens = true,
          treesitter = true,
          treesitter_context = false,
          telescope = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
        custom_highlights = function(colors)
          -- Choose your preferred border color from catppuccin palette:
          -- colors.blue, colors.green, colors.yellow, colors.red, colors.pink,
          -- colors.mauve, colors.peach, colors.teal, colors.sky, colors.sapphire, colors.lavender
          local border_color = colors.surface1 -- Subtle gray border color

          return {
            -- Custom comment color
            Comment = { fg = "#717E85" },

            -- Tab line styling
            TabLineSel = { bg = "#284661", fg = "#dcdcdc", style = { "bold" } },
            TabLine = { bg = "none", fg = "#b0b0b0" },

            -- Global border colors - applies to all floating windows
            FloatBorder = { fg = border_color, bg = "none" },
            NormalFloat = { bg = "none" },

            -- Telescope borders
            TelescopeBorder = { fg = border_color, bg = "none" },
            TelescopePromptBorder = { fg = border_color, bg = "none" },
            TelescopeResultsBorder = { fg = border_color, bg = "none" },
            TelescopePreviewBorder = { fg = border_color, bg = "none" },
            TelescopeTitle = { fg = border_color, style = { "bold" } },

            -- Mason borders
            MasonBorder = { fg = border_color, bg = "none" },
            MasonHeader = { fg = colors.text, bg = "none" },
            MasonHeaderSecondary = { fg = border_color, bg = "none" },

            -- CMP borders and highlights
            CmpBorder = { fg = border_color, bg = "none" },
            CmpDocBorder = { fg = border_color, bg = "none" },
            CmpDocumentationBorder = { fg = border_color, bg = "none" },

            -- Lazy plugin manager borders
            LazyBorder = { fg = border_color, bg = "none" },
            LazyNormal = { bg = "none" },
            LazyFloatBorder = { fg = border_color, bg = "none" },

            -- Which-key borders
            -- WhichKeyBorder = { fg = border_color, bg = "none" },
            -- WhichKeyFloat = { bg = "none" },

            -- Trouble diagnostics borders
            TroubleBorder = { fg = border_color, bg = "none" },
            TroubleNormal = { bg = "none" },

            -- LSP floating windows
            LspInfoBorder = { fg = border_color, bg = "none" },
            DiagnosticFloatingError = { fg = colors.red, bg = "none" },
            DiagnosticFloatingWarn = { fg = colors.yellow, bg = "none" },
            DiagnosticFloatingInfo = { fg = colors.blue, bg = "none" },
            DiagnosticFloatingHint = { fg = colors.teal, bg = "none" },

            -- Neo-tree file explorer borders
            -- NeoTreeBorder = { fg = border_color, bg = "none" },
            -- NeoTreeFloatBorder = { fg = border_color, bg = "none" },
            -- NeoTreePopupBorder = { fg = border_color, bg = "none" },

            -- Additional common plugin borders
            NoiceBorder = { fg = border_color, bg = "none" },  -- Noice plugin
            NotifyBorder = { fg = border_color, bg = "none" }, -- Notify plugin

            -- Treesitter context (sticky scroll)
            TreesitterContext = { bg = "none" },
            TreesitterContextSeparator = { fg = colors.surface1 },
            TreesitterContextLineNumber = { fg = colors.overlay0 },
          }
        end,
      })

      -- Apply colorscheme and ensure transparency
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
