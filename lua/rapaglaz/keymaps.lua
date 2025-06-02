vim.g.mapleader = " "

-- Turn off search highlight after pressing Esc in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- format document
vim.keymap.set("n", "<C-M-l>", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- Buffer/Tabs: Ctrl + Shift + Up
vim.keymap.set({ "n", "t" }, "<C-Right>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set({ "n", "t" }, "<C-Left>", ":tabprevious<CR>", { desc = "Previous tab" })

-- terminal
vim.keymap.set("n", "<C-'>", ":tabnew | terminal<CR>", { desc = "New terminal in tab" })
