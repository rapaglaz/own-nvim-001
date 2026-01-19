return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  -- event = "VeryLazy",
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "ruff" },
      haskell = { "hlint" },
      go = { "golangcilint" },
      markdown = { "woke", "proselint" },
      yaml = { "yamllint" },
      text = { "woke" },
      sh = { "woke" },
      bash = { "woke" },
      fish = { "woke", "fish" },
      zsh = { "woke", "zsh" },
    }

    -- Use an augroup to prevent duplicate autocmds on reload
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        local ok, err = pcall(lint.try_lint)
        if not ok then
          vim.notify("Lint error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      local ok, err = pcall(lint.try_lint)
      if not ok then
        vim.notify("Lint error: " .. tostring(err), vim.log.levels.ERROR)
      end
    end, { desc = "Trigger linting for current file" })
  end,
}
