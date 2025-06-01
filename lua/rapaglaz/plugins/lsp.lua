-- ~/.config/nvim/lua/rapaglaz/plugins/lsp.lua
return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "j-hui/fidget.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lsp_servers = {
        "bashls",
        "cssls",
        "dockerls",
        "docker_compose_language_service",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "tailwindcss",
        "ts_ls",
        "vimls",
        "yamlls",
      }

      mason_lspconfig.setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,
        },
      })
    end,
  },
}
