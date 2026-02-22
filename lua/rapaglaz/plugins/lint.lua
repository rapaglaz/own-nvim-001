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
      go = { "golangcilint" },
      markdown = { "markdownlint-cli2" },
      yaml = { "yamllint" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      fish = { "fish" },
      zsh = { "zsh" },
    }

    -- Use an augroup to prevent duplicate autocmds on reload
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- BufEnter excluded: it fires on every window/buffer switch and causes
    -- unnecessary linter invocations. InsertLeave catches edits before explicit save.
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
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
