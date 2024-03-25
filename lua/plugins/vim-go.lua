local M = {}
function M.config()
    vim.keymap.set("n", "<C-A-l>", ":GoFmt<CR>", opts)
end

return M
