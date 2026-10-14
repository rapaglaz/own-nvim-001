# Neovim config

Personal Neovim 0.12+ configuration, Lua only, plugin manager: lazy.nvim. Lives at `~/.config/nvim`.

## Layout

- `init.lua` – entry point, requires `rapaglaz`.
- `lua/rapaglaz/init.lua` – loads, in order: `keymaps`, `lazy`, `filetypes`, `autocmd`, `options`.
- `lua/rapaglaz/lazy.lua` – lazy.nvim bootstrap and options; imports `rapaglaz.plugins`.
- `lua/rapaglaz/plugins/init.lua` – the plugin list; one `{ import = "rapaglaz.plugins.<name>" }` per file.
- `lua/rapaglaz/plugins/<name>.lua` – one plugin (or tightly related group) per file, returns a lazy.nvim spec.
- `lua/rapaglaz/lsp/keymaps.lua` – LSP keymaps, `lua/rapaglaz/which-key-groups.lua` – which-key group labels.
- `lazy-lock.json` is untracked (gitignored); do not commit it.

## Conventions

- Format with StyLua using `stylua.toml` (2 spaces, 100 columns, double quotes, always call parentheses).
- Language server settings go through `vim.lsp.config()`; servers are installed by mason-lspconfig, which also calls `vim.lsp.enable()`.
- Load plugins lazily (`event`, `cmd`, `keys`, `ft`); eager loading needs a reason.
- Adding a plugin: create `plugins/<name>.lua`, then add its import to `plugins/init.lua`. Add a which-key group if it introduces a new keymap prefix.
- Linters live in `plugins/lint.lua`, formatters in `plugins/conform.lua`, tool installation in `plugins/mason.lua`.
- Comments and identifiers in English. Keep comments short and explain why, not what.
- Do not add plugins, lint rules or MCP servers without asking.

## Verification

- Format check: `stylua --check .`
- Startup errors: `nvim --headless "+qa"` (must print nothing).
- Plugin health: `nvim --headless "+checkhealth lazy" "+qa"` or `:checkhealth` interactively.
- There is no test suite; verify changes by starting Neovim and exercising the affected feature.

## Git

- Conventional commits (`feat`, `fix`, `chore`, `refactor`, `docs`), GPG-signed.
- Branches: `type/short-description`; `main` is the base for PRs.
