return {
	"mason-org/mason.nvim",
	cmf = { "Mason" },
	tag = "stable",
	lazy = false,
	config = function()
		local mason = require("mason")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
				backdrop = 30,
			},
		})
	end
}
