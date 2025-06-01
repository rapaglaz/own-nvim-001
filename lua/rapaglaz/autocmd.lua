local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create a single augroup for all autocmds
local rapaglaz_group = augroup("rapaglaz-group", { clear = true })

-- Setup global LSP keymaps once (with error handling)
local lsp_keymaps = require("rapaglaz.lsp.keymaps")
lsp_keymaps.setup_global_keymaps()

-- Highlight yanked text on e.g. yy,yap etc.
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = rapaglaz_group,
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  desc = "Restore cursor position when opening file",
  pattern = "*",
  group = rapaglaz_group,
  callback = function()
    local line = vim.fn.line("'\"")
    if
        line > 1
        and line <= vim.fn.line("$")
        and vim.bo.filetype ~= "commit"
        and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

-- LSP attach event
autocmd("LspAttach", {
  desc = "Setup LSP keymaps when LSP attaches to buffer",
  group = rapaglaz_group,
  callback = function(event)
    local lsp_keymaps_module = require("rapaglaz.lsp.keymaps")
    lsp_keymaps_module.setup_lsp_keymaps(event.buf)
  end,
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  desc = "Resize splits when window is resized",
  group = rapaglaz_group,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Terminal settings
autocmd("TermOpen", {
  desc = "Terminal settings",
  group = rapaglaz_group,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0

    -- Enter insert mode automatically
    vim.cmd("startinsert")
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  group = rapaglaz_group,
  callback = function()
    -- Save cursor position
    local curpos = vim.api.nvim_win_get_cursor(0)
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})

-- Create directory if it doesn't exist when saving
autocmd("BufWritePre", {
  desc = "Create directory if it doesn't exist",
  group = rapaglaz_group,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Check if file changed outside of Neovim
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if file changed outside of Neovim",
  group = rapaglaz_group,
  command = "checktime",
})

-- Go to last location when opening a file
autocmd("BufRead", {
  desc = "Go to last location when opening a file",
  group = rapaglaz_group,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].large_file then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close NeoTree when it's the last window
autocmd("QuitPre", {
  desc = "Close NeoTree when it's the last window",
  group = rapaglaz_group,
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("neo%-tree") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= "" then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})
