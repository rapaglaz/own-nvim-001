local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	git = { log = { "--since=7 days ago" } },
	ui = {
		border = "rounded", -- or: "single", "double", "rounded", "solid", "shadow"
		backdrop = 70,
		ui = {
			width = 0.8,
			height = 0.8,
		},
	},
}

require("lazy").setup({
	import = "plugins",
	change_detection = { notify = false },
}, opts)
