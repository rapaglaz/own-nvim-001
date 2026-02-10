return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- New nvim-treesitter API (after full rewrite)
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Install parsers
      require("nvim-treesitter").install({
        "angular",
        "astro",
        "bash",
        "c",
        "comment",
        "css",
        "dart",
        "dockerfile",
        "editorconfig",
        "fish",
        "gitcommit",
        "gitignore",
        "go",
        "gotmpl",
        "gowork",
        "gpg",
        "graphql",
        "haskell",
        "html",
        "htmldjango",
        "java",
        "javadoc",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "kotlin",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "ruby",
        "scala",
        "scss",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      })

      -- Enable syntax highlighting via autocommand
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "angular",
          "bash",
          "c",
          "css",
          "dart",
          "dockerfile",
          "editorconfig",
          "fish",
          "go",
          "haskell",
          "html",
          "java",
          "javascript",
          "json",
          "kotlin",
          "lua",
          "markdown",
          "python",
          "rust",
          "scala",
          "sh",
          "svelte",
          "toml",
          "typescript",
          "typescriptreact",
          "vim",
          "vue",
          "yaml",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })

      -- Add custom templ parser
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").templ = {
            install_info = {
              url = "https://github.com/vrischmann/tree-sitter-templ.git",
              files = { "src/parser.c", "src/scanner.c" },
              branch = "master",
            },
          }
        end,
      })

      vim.treesitter.language.register("templ", "templ")
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
