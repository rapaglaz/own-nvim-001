-- NOTE: mapleader must be set here, before lazy.setup() is called
-- (lazy.lua is loaded after keymaps.lua via rapaglaz/init.lua).
-- Setting it after lazy.setup() would cause plugin keymaps to use wrong leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn off search highlight after pressing Esc in normal mode
vim.keymap.set(
  "n",
  "<Esc>",
  "<cmd>nohlsearch<CR>",
  { desc = "Clear search highlight", silent = true }
)

-- Global format file (<leader>cf) - works in normal, visual, and insert mode
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  local ok, conform = pcall(require, "conform")
  if ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.notify("conform.nvim not found!", vim.log.levels.ERROR)
  end
end, { desc = "Format file (conform)", silent = true })

-- Buffer navigation
vim.keymap.set(
  "n",
  "<leader>bd",
  "<cmd>bd<CR>",
  { desc = "Delete buffer", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bn",
  "<cmd>bnext<CR>",
  { desc = "Next buffer", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bp",
  "<cmd>bprevious<CR>",
  { desc = "Previous buffer", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>bl",
  "<cmd>buffers<CR>",
  { desc = "List buffers", silent = true }
)
