return {
	"mfussenegger/nvim-lint",
	config = function()
		vim.env.ESLINT_D_PPID = vim.fn.getpid()
		require("lint").linters_by_ft = {
			lua = { "luacheck" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			python = { "ruff" },
			yaml = { "yamllint" },
			go = { "golangcilint" },
			markdown = { "markdownlint" },
			bash = { "shellcheck" },
			sh = { "shellcheck" },
			json = { "jsonlint" },
			jsonc = { "jsonlint" },
		}

		vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
