local M = {}
function M.config()
    local ok, _ = pcall(require, 'vim-tmux-navigator')
    if not ok then
        return
    end

    vim.keymap.set("", "<leader><left>", ":TmuxNavigateLeft<CR>", opts)
    vim.keymap.set("", "<leader><right>", ":TmuxNavigateRight<CR>", opts)
    vim.keymap.set("", "<leader><up>", ":TmuxNavigateUp<CR>", opts)
    vim.keymap.set("", "<leader><down>", ":TmuxNavigateDown<CR>", opts)
end

return M
