return {
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      local ok, peek = pcall(require, "peek")
      if not ok then
        vim.notify("peek.nvim not loaded: " .. tostring(peek), vim.log.levels.ERROR)
        return
      end

      peek.setup({
        filetype = { "markdown" },
        theme = "dark",
      })
      vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
      vim.api.nvim_create_user_command("PeekClose", peek.close, {})
      vim.keymap.set("n", "<leader>mp", peek.open, { desc = "Markdown Preview (Peek)" })
      vim.keymap.set("n", "<leader>mc", peek.close, { desc = "Close Markdown Preview (Peek)" })
    end,
  },
}
