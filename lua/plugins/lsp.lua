local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"stevearc/conform.nvim",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("mason").setup({
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
		require("mason-lspconfig").setup({
			ensure_installed = {
				"html",
				"cssls",
				"angularls",
				"rust_analyzer",
				"bashls",
				"cssmodules_ls",
				"emmet_language_server",
				"yamlls",
				"tailwindcss",
				"svelte",
				"ruff",
				"pyright",
				"pylsp",
				"jsonls",
				"hls",
				"lua_ls",
				"ts_ls",
				"denols",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				zls = function()
					local lspconfig = require("lspconfig")
					lspconfig.zls.setup({
						root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
						settings = {
							zls = {
								enable_inlay_hints = true,
								enable_snippets = true,
								warn_style = true,
							},
						},
					})
					vim.g.zig_fmt_parse_errors = 0
					vim.g.zig_fmt_autosave = 0
				end,

				lua_ls = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								globals = { "vim" },
								format = {
									enable = true,
									-- Put format options here
									-- NOTE: the value should be STRING!!
									defaultConfig = {
										indent_style = "space",
										indent_size = "2",
									},
								},
							},
						},
					})
				end,
				ts_ls = function()
					local lspconfig = require("lspconfig")
					lspconfig.ts_ls.setup({
						on_attach = on_attach,
						root_dir = nvim_lsp.util.root_pattern("package.json"),
						single_file_support = false,
					})
				end,

				denols = function()
					local lspconfig = require("lspconfig")
					lspconfig.denols.setup({
						on_attach = on_attach,
						root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

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

		vim.keymap.set("n", "<leader>.", function()
			vim.diagnostic.open_float(nil, {
				focusable = true,
				border = "rounded",
				source = "always",
				prefix = "",
				scope = "cursor",
			})
		end, { desc = "Show diagnostic (float)" })

		-- vim.api.nvim_create_autocmd("CursorHold", {
		-- 	pattern = "*",
		-- 	callback = function()
		-- 		vim.diagnostic.open_float(nil, {
		-- 			focusable = false,
		-- 			border = "rounded",
		-- 			source = "always",
		-- 			prefix = "",
		-- 			scope = "cursor",
		-- 		})
		-- 	end,
		-- })
	end,
}
