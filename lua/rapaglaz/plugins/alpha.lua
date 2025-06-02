return {
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local user = vim.loop.os_get_passwd().username or os.getenv("USER") or ""

			dashboard.section.header.val = {
				"",
				"",
				"",
				"hi " .. user,
				"",
			}

			local main_group = {
				type = "group",
				val = {
					dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
					dashboard.button("f", "󰱼  Find file", ":Telescope find_files<CR>"),
					dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
					dashboard.button("p", "  File explorer", ":Neotree toggle<CR>"),
				},
				opts = { spacing = 1 },
			}
			local config_group = {
				type = "group",
				val = {
					dashboard.button("c", "  Open init.lua", ":e $MYVIMRC<CR>"),
					dashboard.button("v", "  Find in config", ":Telescope find_files cwd=~/.config/nvim<CR>"),
					dashboard.button("k", "󰯄  Edit keymaps", ":e ~/.config/nvim/lua/core/keymaps.lua<CR>"),
				},
				opts = { spacing = 1 },
			}
			local system_group = {
				type = "group",
				val = {
					dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
					dashboard.button("m", "  Update Mason", ":Mason<CR>"),
					dashboard.button("h", "  CheckHealth", ":checkhealth<CR>"),
				},
				opts = { spacing = 1 },
			}

			local quit_group = {
				type = "group",
				val = {
					dashboard.button("q", "  Quit", ":qa<CR>"),
				},
				opts = { spacing = 3 },
			}

			dashboard.section.buttons.val = {
				main_group,
				config_group,
				system_group,
				quit_group,
			}

			dashboard.section.footer.val = function()
				local v = vim.version()
				local stat = vim.loop.fs_stat(vim.fn.stdpath("config") .. "/init.lua")
				local build_date = stat and os.date("%d.%m.%Y", stat.mtime.sec) or "unknown"
				return string.format("%d.%d.%d (build %s)", v.major, v.minor, v.patch, build_date)
			end
			alpha.setup(dashboard.config)
		end,
	},
}
