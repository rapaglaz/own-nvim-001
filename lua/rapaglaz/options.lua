-- Highlight current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.breakindent = true -- wrapped lines maintain indent

-- Shows the effects of substitute etc. as you type
vim.opt.inccommand = "split"

-- Smart case-insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true -- case-sensitive if uppercase is used

vim.opt.termguicolors = true

-- Fast updates for better experience
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- for which-key

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 8 -- horizontal scroll offset
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.conceallevel = 2 -- for markdown and other files
vim.opt.isfname:append("@-@")

-- Disable word wrap, enable temporarily with `:set wrap` when needed
vim.opt.wrap = false

-- Folding (treesitter-based for Neovim 0.11+)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99 -- start with all folds open

-- Set completeopt to have a better completion experience
-- https://neovim.io/doc/user/options.html
vim.opt.completeopt = "menuone,noselect,preview"
vim.opt.pumheight = 10 -- max completion items to show

-- Split windows appear below, not above
vim.opt.splitbelow = true

-- Split windows appear to the right instead of left
vim.opt.splitright = true

-- Diagnostics configuration (float-only, no inline text)
vim.diagnostic.config({
  virtual_text = false, -- Disable inline virtual text
  -- signs = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●", -- or other icon, e.g. ""
      [vim.diagnostic.severity.WARN] = "●", -- or other icon, e.g. ""
      [vim.diagnostic.severity.INFO] = "●", -- or other icon, e.g. ""
      [vim.diagnostic.severity.HINT] = "●", -- or other icon, e.g. ""
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
    focusable = false,
    style = "minimal",
  },
})

-- Manual diagnostics only (use <leader>e to show)
-- Auto-show disabled for cleaner experience

-- Disable log because it's slowing down Neovim
vim.lsp.set_log_level(vim.log.levels.OFF)
