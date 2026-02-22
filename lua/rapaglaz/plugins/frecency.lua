return {
    "nvim-telescope/telescope-frecency.nvim",
    version = "*",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    ---@module 'frecency'
    ---@type FrecencyOpts
    opts = {
        -- Show confirmation dialog before validating (pruning) DB
        db_safe_mode = false,
        db_version = "v2",
        -- Automatically remove stale entries exceeding db_validate_threshold
        auto_validate = true,

        -- Default workspace tag to filter; "CWD" filters to current directory.
        -- Can also be set per-call: frecency({ workspace = "CWD" })
        default_workspace = "CWD",

        -- Enable <Tab> / <S-Tab> completion for :workspace_tag: in prompt
        enable_prompt_mappings = true,

        -- "default" = substr matcher, "fuzzy" = fzy matcher (experimental)
        matcher = "fuzzy",

        -- Override path display (same type as telescope.defaults.path_display)
        path_display = { "filename_first" },

        -- Custom workspace tags: tag → directory (or list of directories)
        workspaces = {
            fish = "~/.config/fish",
            nvim = "~/.config/nvim",
            bin = "~/.local/bin",
            conf = "~/.config",
            ssh = "~/.ssh",
            zsh = "~/.zsh",
        }
    },
    config = function(_, opts)
        require("telescope").load_extension("frecency")
        require("frecency.config").setup(opts)

        vim.keymap.set("n", "<leader>pF", function()
            require("telescope").extensions.frecency.frecency({
                workspace = "CWD",
            })
        end, { desc = "Find files (frecency)" })
    end,
}
