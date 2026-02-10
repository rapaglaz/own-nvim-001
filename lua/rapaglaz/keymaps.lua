vim.g.mapleader = " "

-- Turn off search highlight after pressing Esc in normal mode
vim.keymap.set(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR>",
  { desc = "Clear search highlight", noremap = true, silent = true }
)

-- Global format file (<leader>cf) - works in normal, visual, and insert mode
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.notify("conform.nvim not found!", vim.log.levels.ERROR)
  end
end, { desc = "Format file (conform)", noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set(
  "n",
  "<leader>bd",
  "<cmd>bd<CR>",
  { desc = "Delete buffer", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bn",
  "<cmd>bnext<CR>",
  { desc = "Next buffer", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bp",
  "<cmd>bprevious<CR>",
  { desc = "Previous buffer", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bl",
  "<cmd>buffers<CR>",
  { desc = "List buffers", noremap = true, silent = true }
)

-- Register in which-key
local ok_wk, which_key = pcall(require, "which-key")
if ok_wk then
  which_key.register({
    ["<leader>c"] = { name = "+code" },
    ["<leader>cf"] = "Format file (conform)",
    ["<leader>b"] = { name = "+buffer" },
  })
end
