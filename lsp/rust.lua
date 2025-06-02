---@type vim.lsp.Config

return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_dir = { "Cargo.toml", "rust-project.json", ".git" },
}
