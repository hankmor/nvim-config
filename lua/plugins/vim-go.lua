local M = {}
function M.config()
    vim.keymap.set("", "<C-A-l>", ":GoFmt<CR>", opts)
    vim.keymap.set("n", "<C-A-r>", ":GoRun<CR>", opts)
    vim.keymap.set("n", "<C-A-t>", ":GoTestFunc<CR>", opts)
    vim.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", opts)
end

return M
