return {
	"NvChad/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			filetypes = { "*" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = true, -- "blue" etc
				RRGGBBAA = true,
				rgb_fn = true, -- rgb(), rgba()
				hsl_fn = true, -- hsl(), hsla()
				css = true,
				css_fn = true,
				mode = "background", -- oe "virtualtext"
			},
		})
	end,
}
