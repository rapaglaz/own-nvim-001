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
        "angularls",
        "astro",
        "bashls",
        "cssls",
        "denols",
        "docker_compose_language_service",
        "docker_language_server",
        "dockerls",
        "fish_lsp",
        "gh_actions_ls",
        "gopls",
        "html",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "svelte",
        "tailwindcss",
        "taplo",
        "ts_ls",
        "vimls",
        "vuels",
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
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,

          -- TypeScript with inlay hints
          ["ts_ls"] = function()
            lspconfig.ts_ls.setup({
              capabilities = capabilities,
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayFunctionParameterTypeHints = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
