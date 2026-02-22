local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create a single augroup for all autocmds
local rapaglaz_group = augroup("rapaglaz-group", { clear = true })

-- Namespace created once at module level, not inside hot callbacks
local current_line_diag_ns = vim.api.nvim_create_namespace("current_line_diagnostics")
-- Per-buffer cache: bufnr -> last line where diagnostics were rendered.
-- Avoids redundant clear+set on every CursorHold tick when the cursor hasn't moved.
local _last_diag_line = {}

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
    -- reuse the module already required at the top of this file
    lsp_keymaps.setup_lsp_keymaps(event.buf)
  end,
})

-- Show virtual_text only for current line with diagnostic
autocmd({ "CursorHold", "CursorHoldI" }, {
  desc = "Show virtual_text only on current line with diagnostic",
  group = rapaglaz_group,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1

    -- Skip if cursor is still on same line (avoid redundant work)
    if _last_diag_line[bufnr] == line then return end
    _last_diag_line[bufnr] = line

    -- Clear previous virtual text extmarks directly (avoids hide/show cycle flicker)
    vim.api.nvim_buf_clear_namespace(bufnr, current_line_diag_ns, 0, -1)

    -- Get diagnostics for current line
    local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })

    -- Show virtual text only if there are diagnostics on current line.
    -- vim.diagnostic.show() with 4 args is deprecated in 0.11;
    -- use set() to push diagnostics into the namespace and config() for display opts.
    if #diagnostics > 0 then
      vim.diagnostic.set(current_line_diag_ns, bufnr, diagnostics)
      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = "■",
        },
      }, current_line_diag_ns)
    end
  end,
})

-- Clean up per-buffer diagnostic cache when a buffer is deleted
autocmd("BufDelete", {
  desc = "Clean up per-buffer diagnostic line cache",
  group = rapaglaz_group,
  callback = function(ev)
    _last_diag_line[ev.buf] = nil
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
-- Skipped for readonly/non-modifiable buffers, binary, and special filetypes
-- to avoid corrupting patches, diffs, git commits, etc.
local whitespace_excluded_ft = {
  diff = true,
  gitcommit = true,
  gitrebase = true,
  xxd = true,
  markdown = true, -- whitespace may be intentional (trailing 2-space newline)
}
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  pattern = "*",
  group = rapaglaz_group,
  callback = function()
    if not vim.bo.modifiable
        or vim.bo.readonly
        or vim.bo.binary
        or whitespace_excluded_ft[vim.bo.filetype]
    then
      return
    end
    -- Save cursor position
    local curpos = vim.api.nvim_win_get_cursor(0)
    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])
    -- Restore cursor position — guard against buffer becoming shorter after substitution
    local line_count = vim.api.nvim_buf_line_count(0)
    if curpos[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, curpos)
    end
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
