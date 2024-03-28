local M = {}
function M.config()
    -- local ok, _ = pcall(require, 'vim-tmux-navigator')
    -- if not ok then
    --     return
    -- end

    vim.keymap.set({"n", "i", "v"}, "<leader><left>", "<cmd>:TmuxNavigateLeft<CR>", opts)
    vim.keymap.set({"n", "i", "v"}, "<leader><right>", "<cmd>:TmuxNavigateRight<CR>", opts)
    vim.keymap.set({"n", "i", "v"}, "<leader><up>", "<cmd>:TmuxNavigateUp<CR>", opts)
    vim.keymap.set({"n", "i", "v"}, "<leader><down>", "<cmd>:TmuxNavigateDown<CR>", opts)
end

return M
