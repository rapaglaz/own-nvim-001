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

-- Rejestracja w which-key (bezpieczne require - pluginy mogą jeszcze nie być załadowane)
local ok_wk, which_key = pcall(require, "which-key")
if ok_wk then
  which_key.register({
    ["<leader>c"] = { name = "+code" },
    ["<leader>cf"] = "Format file (conform)",
  })
end
