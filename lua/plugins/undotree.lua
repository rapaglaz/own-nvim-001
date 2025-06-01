return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<F2>", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
		},
		init = function()
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 40
			vim.g.undotree_SetFocusWhenToggle = 1
		end,
	},
}
