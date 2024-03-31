local M = {}

function M.config()
    require("lsp_lines").setup()
    VIM.keymap.set( "", "<Leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
end

return M
