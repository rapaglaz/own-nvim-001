return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        -- lsp_format = "fallback": consistent with the manual <leader>cf keymap
        -- (conform falls back to LSP when no formatter is configured for the ft)
        -- lsp_fallback was renamed to lsp_format in conform.nvim v7+
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        toml = { "taplo" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        rust = { "rustfmt" },
        python = { "ruff" },
        go = { "gofmt" },
        haskell = { "fourmolu", "ormolu", stop_after_first = true },
        sh = { "shfmt" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
      },
    })
  end,
}
