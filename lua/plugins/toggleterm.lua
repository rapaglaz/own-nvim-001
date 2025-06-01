return {
	{
		"akinsho/toggleterm.nvim",
		enabled = true,
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 15,
				open_mapping = [[<C-'>]],
				hide_numbers = true,
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = false,
				direction = "horizontal", -- default direction
				float_opts = {
					border = "curved",
					winblend = 3,
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal

			-- Float terminal (F3)
			local float_term = Terminal:new({ direction = "float", hidden = true })
			vim.keymap.set("n", "<leader><F3>", function()
				float_term:toggle()
			end, { desc = "Toggle float terminal" })

			-- Vertical terminal (F4)
			local vertical_term = Terminal:new({ direction = "vertical", size = 50, hidden = true })
			vim.keymap.set("n", "<leader><F4>", function()
				vertical_term:toggle()
			end, { desc = "Toggle vertical terminal" })

			-- Git terminal (F5)
			local git_term = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
			vim.keymap.set("n", "<leader><F5>", function()
				git_term:toggle()
			end, { desc = "Toggle LazyGit" })

			---------------------------------------------------------------------
			-- ToggleTerm navigation: cmd+alt+] / cmd+alt+[ (next/prev terminal)
			---------------------------------------------------------------------

			-- Use <D-Alt-]> and <D-Alt-[> (macOS: cmd+alt+] / cmd+alt+[) for next/prev terminal
			-- For Linux/Windows: You may remap to <A-]> and <A-[> or similar
			vim.keymap.set({ "n", "t" }, "<D-A-]>", function()
				require("toggleterm").next_terminal()
			end, { desc = "Next ToggleTerm" })

			vim.keymap.set({ "n", "t" }, "<D-A-[>", function()
				require("toggleterm").prev_terminal()
			end, { desc = "Previous ToggleTerm" })

			---------------------------------------------------------------------
			-- Neovim tab switching: Ctrl+Arrow Right/Left
			---------------------------------------------------------------------
			vim.keymap.set({ "n", "t" }, "<C-Right>", ":tabnext<CR>", { desc = "Next tab" })
			vim.keymap.set({ "n", "t" }, "<C-Left>", ":tabprevious<CR>", { desc = "Previous tab" })
		end,
	},
}
