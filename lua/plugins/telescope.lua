return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", enabled = vim.fn.executable("make") == 1 },
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		event = "VeryLazy",
		config = function()
			local telescope = require("telescope")
			local utils = require("telescope.utils")

			-- Dynamically detect project root by typical config/build files (npm, Cargo, Python, Go, etc.)
			local function get_project_root()
				local patterns = {
					"package.json",
					"pyproject.toml",
					"Cargo.toml",
					"Makefile",
					"go.mod",
					"composer.json",
					"requirements.txt",
					"tsconfig.json",
					"pnpm-workspace.yaml",
					"yarn.lock",
					"Gemfile",
					"build.gradle",
					"settings.gradle",
					"deno.json",
					"elm.json",
				}
				local path = vim.fn.expand("%:p:h")
				for _, pattern in ipairs(patterns) do
					local found = vim.fs.find(pattern, { upward = true, path = path })[1]
					if found then
						return vim.fn.fnamemodify(found, ":p:h")
					end
				end
				return vim.fn.getcwd()
			end

			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = "top",
						width = 0.9,
						height = 0.8,
					},
					sorting_strategy = "ascending",
					-- winblend = 3,
				},
				pickers = {
					-- Use ripgrep for fast file search and exclude typical unwanted directories/files
					find_files = {
						theme = "dropdown",
						hidden = true,
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!.git/*",
							"--glob",
							"!node_modules/*",
							"--glob",
							"!dist/*",
							"--glob",
							"!build/*",
							"--glob",
							"!.cache/*",
							"--glob",
							"!.venv/*",
							"--glob",
							"!out/*",
							"--glob",
							"!logs/*",
							"--glob",
							"!.pytest_cache/*",
							"--glob",
							"!__pycache__/*",
							"--glob",
							"!.parcel-cache/*",
							"--glob",
							"!.idea/*",
							"--glob",
							"!.vscode/*",
						},
					},
					live_grep = { theme = "dropdown" },
					buffers = { theme = "dropdown" },
					oldfiles = { theme = "dropdown" },
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					live_grep_args = {},
				},
			})

			-- Try loading extensions (do not fail if not installed)
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "live_grep_args")

			-- ============ KEYMAPS ============

			-- Find files from project root (detected by config/build files or .git)
			vim.keymap.set("n", "<leader>ff", function()
				require("telescope.builtin").find_files({
					cwd = get_project_root(),
					hidden = true,
				})
			end, { desc = "Find files (project root)" })

			-- Find files from current working directory (without project root)
			vim.keymap.set("n", "<leader>fF", function()
				require("telescope.builtin").find_files({
					cwd = vim.fn.getcwd(),
					hidden = true,
				})
			end, { desc = "Find files (local dir)" })

			-- Live grep from project root
			vim.keymap.set("n", "<leader>fg", function()
				require("telescope.builtin").live_grep({
					cwd = get_project_root(),
				})
			end, { desc = "Live grep (project root)" })

			-- Live grep with args from project root (uses extension)
			vim.keymap.set("n", "<leader>fw", function()
				require("telescope").extensions.live_grep_args.live_grep_args({
					cwd = get_project_root(),
				})
			end, { desc = "Live grep (args, project root)" })

			-- Buffers, recent files, help, commands, keymaps, marks, resume last search
			vim.keymap.set("n", "<leader>fb", function()
				require("telescope.builtin").buffers()
			end, { desc = "Find buffers" })

			vim.keymap.set("n", "<leader>fr", function()
				require("telescope.builtin").oldfiles()
			end, { desc = "Recent files" })

			vim.keymap.set("n", "<leader>fh", function()
				require("telescope.builtin").help_tags()
			end, { desc = "Help tags" })

			vim.keymap.set("n", "<leader>fc", function()
				require("telescope.builtin").commands()
			end, { desc = "Commands" })

			vim.keymap.set("n", "<leader>fk", function()
				require("telescope.builtin").keymaps()
			end, { desc = "Keymaps" })

			vim.keymap.set("n", "<leader>fm", function()
				require("telescope.builtin").marks()
			end, { desc = "Marks" })

			vim.keymap.set("n", "<leader>fl", function()
				require("telescope.builtin").resume()
			end, { desc = "Resume last search" })
		end,
	},
}
