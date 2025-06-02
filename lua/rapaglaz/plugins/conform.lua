return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		require("conform").setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
				yaml = { "prettier" },
				toml = { "taplo" },
				python = { "ruff" },
				go = { "gofumpt" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
				kotlin = { "ktlint" },
				haskell = { "ormolu" },
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					async = false,
					lsp_fallback = true,
				})
			end,
		})
	end,
}
