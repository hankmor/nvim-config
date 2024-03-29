local M = {}
function M.config()
    -- local ok, _ = pcall(require, 'vim-tmux-navigator')
    -- if not ok then
    --     return
    -- end

    VIM.keymap.set({"n", "i", "v"}, "<leader><left>", "<cmd>:TmuxNavigateLeft<CR>", OPTS)
    VIM.keymap.set({"n", "i", "v"}, "<leader><right>", "<cmd>:TmuxNavigateRight<CR>", OPTS)
    VIM.keymap.set({"n", "i", "v"}, "<leader><up>", "<cmd>:TmuxNavigateUp<CR>", OPTS)
    VIM.keymap.set({"n", "i", "v"}, "<leader><down>", "<cmd>:TmuxNavigateDown<CR>", OPTS)
end

return M
