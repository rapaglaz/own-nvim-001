return {
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        -- mini.icons matches "icons" as a special filename and returns '?';
        -- override to use the Lua icon since it's just a .lua config file
        ["icons.lua"] = { glyph = "󰢱", hl = "MiniIconsAzure" },
      },
    },
    init = function()
      -- Mock nvim-web-devicons API so plugins that depend on it work transparently
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
