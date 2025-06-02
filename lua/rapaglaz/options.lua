vim.lsp.enable({
	"angular",
	"bash",
	"css",
	-- "deno",
	"docker-compose",
	"go",
	"html",
	"lua",
	"marksman",
	-- "python",
	"tailwind",
	"ts",
	"yaml",
})

-- Highlight current line
vim.opt.cursorline = true
vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Shows the effects of substitute etc. as you type
vim.opt.inccommand = "split"

-- Case-insensitive search
vim.opt.ignorecase = true


vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 7
-- Separate sign colum (extra column for Git/LSP)
vim.wo.signcolumn = "yes"
-- vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Disable word wrap, enable temporarily with `:set wrap` when needed
vim.opt.wrap = false

vim.opt.termguicolors = true

-- vim.cmd.colorscheme("")

-- Set completeopt to have a better completion experience
-- https://neovim.io/doc/user/options.html
vim.opt.completeopt = "menuone,noselect"

-- Split windows appear below, not above
vim.opt.splitbelow = true

-- Split windows appear to the right instead of left
vim.opt.splitright = true

-- Rounded borders
vim.opt.winborder = "rounded"

-- Inline hints
vim.diagnostic.config({
	virtual_lines = { current_line = true },
	-- signs = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●", -- lub inna ikona, np. ""
			[vim.diagnostic.severity.WARN] = "●", -- lub inna ikona, np. ""
			[vim.diagnostic.severity.INFO] = "●", -- lub inna ikona, np. ""
			[vim.diagnostic.severity.HINT] = "●", -- lub inna ikona, np. ""
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	-- float = {
	-- 	border = "rounded",
	-- 	source = "always",
	-- 	header = "",
	-- prefix = "",
	-- },
})

-- Disable log because it's slowing down Neovim
vim.lsp.log_levels = "OFF"
