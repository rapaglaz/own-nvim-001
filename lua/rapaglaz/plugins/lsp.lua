-- ~/.config/nvim/lua/rapaglaz/plugins/lsp.lua
return {
  -- Better Lua LSP support: scoped library indexing instead of
  -- vim.api.nvim_get_runtime_file("", true) which indexes 700+ files
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "j-hui/fidget.nvim" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Reused across all default-handler setups to avoid creating a new table per server
      local default_opts = { capabilities = capabilities }

      local lsp_servers = {
        "bashls",
        "cssls",
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
        "tailwindcss",
        "taplo",
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
            lspconfig[server_name].setup(default_opts)
          end,
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    -- Only index VIMRUNTIME; lazydev.nvim handles plugin libs
                    -- vim.api.nvim_get_runtime_file("", true) indexes 700+ files
                    library = { vim.env.VIMRUNTIME },
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
