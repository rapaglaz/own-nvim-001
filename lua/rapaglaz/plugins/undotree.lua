return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<F2>", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree (Leader)" },
    },
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 40
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_HelpLine = 0
      vim.g.undotree_DiffAutoOpen = 1
    end,
  },
}
