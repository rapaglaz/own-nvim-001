return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            local harpoon = require("harpoon")

            -- REQUIRED setup
            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true,
                },
            })

            -- Load Telescope extension
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end

            -- Keymaps
            vim.keymap.set("n", "<leader>ha", function()
                harpoon:list():add()
            end, { desc = "Harpoon: Add file" })

            vim.keymap.set("n", "<leader>hh", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Harpoon: Show menu (Telescope)" })

            vim.keymap.set("n", "<leader>hr", function()
                harpoon:list():remove()
            end, { desc = "Harpoon: Remove file" })

            vim.keymap.set("n", "<leader>hc", function()
                harpoon:list():clear()
            end, { desc = "Harpoon: Clear all" })

            -- Quick navigation to marks 1-4
            vim.keymap.set("n", "<leader>h1", function()
                harpoon:list():select(1)
            end, { desc = "Harpoon: Go to file 1" })

            vim.keymap.set("n", "<leader>h2", function()
                harpoon:list():select(2)
            end, { desc = "Harpoon: Go to file 2" })

            vim.keymap.set("n", "<leader>h3", function()
                harpoon:list():select(3)
            end, { desc = "Harpoon: Go to file 3" })

            vim.keymap.set("n", "<leader>h4", function()
                harpoon:list():select(4)
            end, { desc = "Harpoon: Go to file 4" })

            -- Navigate to next/previous mark
            vim.keymap.set("n", "<leader>hn", function()
                harpoon:list():next()
            end, { desc = "Harpoon: Next file" })

            vim.keymap.set("n", "<leader>hp", function()
                harpoon:list():prev()
            end, { desc = "Harpoon: Previous file" })
        end,
    },
}
