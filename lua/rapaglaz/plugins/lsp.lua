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

  { "b0o/schemastore.nvim" },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "j-hui/fidget.nvim", "b0o/schemastore.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- Enable workspace/didChangeWatchedFiles so LSPs react to out-of-buffer
      -- changes (e.g. git checkout, code generators, tsc --watch output).
      capabilities.workspace = vim.tbl_deep_extend("force", capabilities.workspace or {}, {
        didChangeWatchedFiles = { dynamicRegistration = true },
      })

      -- mason-lspconfig v2 only installs servers and calls vim.lsp.enable();
      -- per-server options must go through vim.lsp.config() (nvim 0.11+).
      vim.lsp.config("*", { capabilities = capabilities })

      -- nvim 0.12 enables document_color by default; nvim-highlight-colors already
      -- handles color rendering with broader support (hex, Tailwind, etc.) so
      -- disable the LSP one to avoid duplicate virtual text decorations.
      vim.lsp.document_color.enable(false)

      vim.lsp.config("lua_ls", {
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

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      -- TypeScript with inlay hints
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayFunctionParameterTypeHints = true,
            },
          },
        },
      })

      local lsp_servers = {
        "angularls",
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

      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_enable = {
          -- Mason also ships these as LSP servers, but they are used through
          -- conform.nvim / pyright here; an extra client would duplicate them.
          exclude = { "ruff", "stylua" },
        },
      })

      -- Deno comes from the system binary, not Mason. nvim-lspconfig's denols
      -- root_dir only matches deno.json/deno.jsonc/deno.lock projects, and ts_ls
      -- backs off there, so the two never attach to the same buffer.
      if vim.fn.executable("deno") == 1 then
        vim.lsp.enable("denols")
      end

      if vim.fn.executable("haskell-language-server-wrapper") == 1 then
        vim.lsp.config("hls", {
          settings = {
            haskell = {
              formattingProvider = "fourmolu",
            },
          },
        })
        vim.lsp.enable("hls")
      end
    end,
  },
}
