return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      -- New nvim-treesitter API (after full rewrite)
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Install parsers — deferred so it doesn't block startup
      vim.schedule(function()
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
          "templ",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        })
      end) -- end vim.schedule

      -- Enable syntax highlighting for any filetype that has a parser installed.
      -- pcall silently skips filetypes with no parser instead of erroring.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(ev)
          -- Skip special buffers (terminal, quickfix, prompt, etc.)
          -- to avoid pcall noise and unnecessary parser lookups.
          if vim.bo[ev.buf].buftype ~= "" then return end
          pcall(vim.treesitter.start)
        end,
      })

      -- Register templ filetype with treesitter.
      -- Signature: register(lang, filetype) — correctly maps filetype "templ" to the
      -- "templ" parser installed above. Arguments are NOT reversed.
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
