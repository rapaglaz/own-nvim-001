return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local user = os.getenv("USER") or ""

      dashboard.section.header.val = {
        "",
        "  Hi " .. user,
        "",
      }

      local main_group = {
        type = "group",
        val = {
          dashboard.button("e", "New file", ":ene <BAR> startinsert<CR>"),
          dashboard.button("f", "Find file", ":Telescope frecency workspace=CWD<CR>"),
          dashboard.button("r", "Recent", ":Telescope oldfiles<CR>"),
          dashboard.button(
            "p",
            "File explorer",
            ":Neotree toggle source=filesystem reveal=true position=float<CR>"
          ),
        },
        opts = { spacing = 1 },
      }
      local config_group = {
        type = "group",
        val = {
          dashboard.button("v", "Find in config", ":Telescope find_files cwd=~/.config/nvim<CR>"),
        },
        opts = { spacing = 1 },
      }
      local system_group = {
        type = "group",
        val = {
          dashboard.button("u", "Update plugins", ":Lazy update<CR>"),
          dashboard.button("m", "Update Mason", ":Mason<CR>"),
          dashboard.button("h", "CheckHealth", ":checkhealth<CR>"),
        },
        opts = { spacing = 1 },
      }
      local docs_group = {
        type = "group",
        val = {
          dashboard.button("d", "Help", ":Telescope help_tags<CR>"),
          dashboard.button("q", "Quit", ":qa<CR>"),
        },
        opts = { spacing = 1 },
      }

      dashboard.section.buttons.val = {
        main_group,
        config_group,
        system_group,
        docs_group,
      }

      dashboard.section.footer.val = function()
        local v = vim.version()
        return string.format("v%d.%d.%d", v.major, v.minor, v.patch)
      end
      alpha.setup(dashboard.config)
    end,
  },
}
