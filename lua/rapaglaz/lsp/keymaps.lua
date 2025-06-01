-- LSP Keymaps module
local M = {}

-- Helper function for setting keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Buffer-local LSP keymaps
function M.setup_lsp_keymaps(bufnr)
    local buf_opts = { buffer = bufnr }

    -- Navigation
    map(
        "n",
        "gd",
        vim.lsp.buf.definition,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Go to Definition" })
    )
    map(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Go to Declaration" })
    )
    map(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Go to Implementation" })
    )
    map(
        "n",
        "gt",
        vim.lsp.buf.type_definition,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Go to Type Definition" })
    )
    map(
        "n",
        "gr",
        vim.lsp.buf.references,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Show References" })
    )

    -- Actions
    map(
        "n",
        "<leader>rn",
        vim.lsp.buf.rename,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Rename Symbol" })
    )
    map(
        { "n", "v" },
        "<leader>ca",
        vim.lsp.buf.code_action,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Code Actions" })
    )

    -- Information
    map(
        "n",
        "K",
        vim.lsp.buf.hover,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Hover Documentation" })
    )
    map(
        "n",
        "<C-k>",
        vim.lsp.buf.signature_help,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Signature Help" })
    )

    -- Workspace
    map(
        "n",
        "<leader>wa",
        vim.lsp.buf.add_workspace_folder,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Add Workspace Folder" })
    )
    map(
        "n",
        "<leader>wr",
        vim.lsp.buf.remove_workspace_folder,
        vim.tbl_extend("force", buf_opts, { desc = "LSP: Remove Workspace Folder" })
    )
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", buf_opts, { desc = "LSP: List Workspace Folders" }))

    -- Inlay hints
    if vim.lsp.inlay_hint then
        map('n', '<leader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, vim.tbl_extend('force', buf_opts, { desc = 'LSP: Toggle Inlay Hints' }))
    end
end

-- Global LSP keymaps (available everywhere)
function M.setup_global_keymaps()
    map("n", "<leader>e", vim.diagnostic.open_float, { desc = "LSP: Show Line Diagnostics" })
    map("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP: Previous Diagnostic" })
    map("n", "]d", vim.diagnostic.goto_next, { desc = "LSP: Next Diagnostic" })
    map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: Diagnostics to Location List" })

    -- Telescope LSP integration (if available)
    local telescope_ok, telescope_builtin = pcall(require, "telescope.builtin")
    if telescope_ok then
        map(
            "n",
            "<leader>ds",
            telescope_builtin.lsp_document_symbols,
            { desc = "LSP: Document Symbols" }
        )
        map(
            "n",
            "<leader>ws",
            telescope_builtin.lsp_dynamic_workspace_symbols,
            { desc = "LSP: Workspace Symbols" }
        )
    end
end

return M
