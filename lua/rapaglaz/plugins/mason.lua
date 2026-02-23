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
          "prettierd",
          "stylua",
          "taplo",
          "ruff",
          "shfmt",
          "eslint_d",
          "shellcheck",
          "markdownlint-cli2",
          "yamllint",
          "golangci-lint",
          "treesitter_cli",
        },

        -- Auto-update disabled: prevents background activity on every startup.
        -- Run :MasonToolsUpdate manually or via :Lazy build mason-tool-installer.
        auto_update = false,

        -- run_on_start: only install missing tools, not update existing ones.
        -- Kept true but combined with auto_update=false it won't re-update.
        run_on_start = true,

        -- Delay after opening Neovim before starting installation (in ms)
        start_delay = 3000,

        -- Only install tools that are not already installed
        debounce_hours = 24,
      })
    end,
  },
}
