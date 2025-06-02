-- Some things are from https://www.josean.com/posts/neovim-linting-and-formatting
return {
	"stevearc/conform.nvim",
	enabled = true,
	tag = "stable",
	opts = {},
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- yaml.docker-compose = { "prettier" },
				markdown = { "prettier" },
				text = { "woke" },
				graphql = { "prettier" },
				lua = { "stylua" },
				python = { "ruff" },
				sh = { "shfmt" },
				-- terraform = { "tflint" },
				hcl = { "hclfmt" },
			},
			stop_after_first = false,
			format_on_save = {
				-- lsp_fallback = true,
				lsp_format = "fallback",
				async = false,
				timeout_ms = 1000, -- default: 1000
			},
		})
	end,
}
