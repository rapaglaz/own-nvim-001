return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
    build = ":MasonUpdate",
    event = "VeryLazy",
    config = function()
      local mason = require("mason")
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "rounded",
          backdrop = 30,
        },
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    config = function()
      require("mason-tool-installer").setup({
        -- NOTE: LSP servers are handled by mason-lspconfig.nvim, not here
        ensure_installed = {
          "prettier",
          "stylua",
          "taplo",
          "ruff",
          "shfmt",
          "eslint_d",
          "shellcheck",
          "markdownlint-cli2",
        },

        -- Auto-update tools
        auto_update = true,

        -- Run on start (when opening Neovim)
        run_on_start = true,

        -- Delay after opening Neovim before starting installation (in ms)
        start_delay = 3000,

        -- Only install tools that are not already installed
        debounce_hours = 24,
      })
    end,
  },
}
