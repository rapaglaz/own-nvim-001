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
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
        markdown = { "prettier" },
        rust = { "rustfmt" },
        python = { "ruff" },
        go = { "gofmt" },
        haskell = { "ormolu" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        fish = { "fish_indent" },
      },
    })
  end,
}
