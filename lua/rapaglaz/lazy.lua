local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  -- Git configuration
  git = {
    log = { "--since=3 days ago" }, -- reduced for performance
    timeout = 120,
  },

  -- UI configuration
  ui = {
    border = "rounded",
    backdrop = 60,
    size = {
      width = 0.8,
      height = 0.8,
    },
    wrap = true, -- wrap long lines in plugin descriptions
  },

  -- Performance optimizations
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },

  -- Installation configuration
  install = {
    missing = true,                 -- install missing plugins on startup
    colorscheme = { "catppuccin" }, -- try to load color schemes in this order
  },

  -- Update checker
  checker = {
    enabled = true,
    concurrency = 2,
    notify = false,    -- don't notify about updates
    frequency = 86400, -- check once a day
  },

  -- Change detection
  change_detection = {
    enabled = true,
    notify = false, -- don't notify about config changes
  },
}

require("lazy").setup({
  { import = "rapaglaz.plugins" },
}, opts)
