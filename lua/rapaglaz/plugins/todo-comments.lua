return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            signs = false,
        },
        keys = {
            { "<leader>st", "<cmd>TodoTelescope<CR>",                            desc = "Search TODOs" },
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next TODO" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
        },
    },
}
