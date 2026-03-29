return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local install_dir = vim.fn.stdpath("data") .. "/site"

      require("nvim-treesitter").setup({
        install_dir = install_dir, -- setup() normalizes + prepends to rtp automatically
      })

      -- install_dir
      vim.o.rtp = vim.o.rtp .. "," .. install_dir .. "/"

      -- Install parsers — deferred so it doesn't block startup
      vim.schedule(function()
        require("nvim-treesitter").install({
          "apache",
          "astro",
          "awk",
          "bash",
          "comment",
          "css",
          "diff",
          "dockerfile",
          "fish",
          "git_rebase",
          "gitcommit",
          "gitignore",
          "git_config",
          "go",
          "gomod",
          "gosum",
          "gotmpl",
          "gpg",
          "graphql",
          "hcl",
          "html",
          "ini",
          "java",
          "javascript",
          "jsdoc",
          "json",
          "jq",
          "json5",
          "kotlin",
          "lua",
          "luadoc",
          "make",
          "markdown",
          "nginx",
          "markdown_inline",
          "properties",
          "proto",
          "python",
          "regex",
          "rust",
          "scss",
          "sql",
          "ssh_config",
          "svelte",
          "templ",
          "terraform",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "xml",
          "yaml",
        })
      end)

      -- Enable syntax highlighting for any filetype that has a parser installed.
      -- pcall silently skips filetypes with no parser instead of erroring.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(ev)
          -- Skip special buffers (terminal, quickfix, prompt, etc.)
          -- to avoid pcall noise and unnecessary parser lookups.
          if vim.bo[ev.buf].buftype ~= "" then
            return
          end
          pcall(vim.treesitter.start)
        end,
      })

      -- Map filetypes to parsers.
      -- Signature: register(lang, filetype) — lang is the parser name, filetype is the vim filetype.
      vim.treesitter.language.register("templ",  "templ")
      -- compound yaml filetypes → reuse yaml parser
      vim.treesitter.language.register("yaml",   "yaml.docker-compose")
      vim.treesitter.language.register("yaml",   "yaml.gitlab")
      vim.treesitter.language.register("yaml",   "yaml.helm-values")
      -- Go template filetypes → reuse gotmpl parser
      vim.treesitter.language.register("gotmpl",     "gotmpl")
      vim.treesitter.language.register("gotmpl",     "gohtmltmpl")
      vim.treesitter.language.register("gotmpl",     "gohtml")
      -- Neovim detects .properties as "jproperties"; treesitter parser is "properties"
      vim.treesitter.language.register("properties", "jproperties")
      -- Neovim detects ssh config as "sshconfig"; treesitter parser is "ssh_config"
      vim.treesitter.language.register("ssh_config", "sshconfig")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = "─",
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
}
