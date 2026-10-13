return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gG", vim.cmd.Git, { desc = "Git status (fugitive)" })
    local autocmd = vim.api.nvim_create_autocmd

    autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>gp", function()
          vim.cmd.Git("push")
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>gP", function()
          vim.cmd.Git({ "pull", "--rebase" })
        end, opts)

        -- not a <leader>gp prefix: that would delay <leader>gp by 'timeoutlen'
        vim.keymap.set("n", "<leader>gU", ":Git push -u origin ", opts)
      end,
    })

    -- Merge conflict helpers: buffer-local to diff windows so they do not
    -- shadow the built-in gu{motion} operator and gh (select mode) elsewhere.
    autocmd("BufWinEnter", {
      pattern = "*",
      callback = function(ev)
        if not vim.wo.diff then
          return
        end
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>", { buffer = ev.buf, desc = "Diffget target (//2)" })
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>", { buffer = ev.buf, desc = "Diffget merge (//3)" })
      end,
    })
  end,
}
