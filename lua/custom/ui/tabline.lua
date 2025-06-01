local M = {}

function M.setup()
    vim.opt.showtabline = 2
    vim.o.tabline = "%!v:lua.require'custom.ui.tabline'.render()"
end

function M.render()
    local s = ""
    for i = 1, vim.fn.tabpagenr("$") do
        local winnr = vim.fn.tabpagewinnr(i)
        local buflist = vim.fn.tabpagebuflist(i)
        local bufnr = buflist[winnr]
        local bufname = vim.fn.bufname(bufnr)
        local label = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"

        -- Status icon (example: green/red/gray circle)
        local is_modified = vim.fn.getbufvar(bufnr, "&modified") == 1
        local is_active = i == vim.fn.tabpagenr()
        local icon = ""
        if is_modified and is_active then
            icon = "●"
        elseif is_modified and not is_active then
            icon = "○"
        else
            icon = ""
        end

        -- Highlight for active/inactive tab
        if i == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSel#"
        else
            s = s .. "%#TabLine#"
        end

        s = s .. " " .. icon .. " " .. label .. "  "
    end
    s = s .. "%#TabLineFill#"
    return s
end

return M
