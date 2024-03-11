local M = {}
function M.config()
    local ok, _ = pcall(require, "lsp_lines")
    if not ok then
        return
    end

    require("lsp_lines").setup()
    vim.keymap.set("", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
end

return M
