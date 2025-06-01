return {
  enabled = true,
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = " ", right = "" },
        section_separators = { left = "", right = " " },
        globalstatus = true,
        icons_enabled = false,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
          "filename",
        },
        lualine_x = {
          "encoding",
          "location",
          "progress",
        },
        lualine_y = {},
        lualine_z = {
          function()
            return os.date("%H:%M")
          end,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {
        "neo-tree",
        "nvim-tree",
        "fugitive",
        "toggleterm",
        "quickfix",
        "trouble",
        "man",
        "symbols-outline",
      },
    })
  end,
}
