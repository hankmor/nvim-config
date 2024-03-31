return {
    "christoomey/vim-tmux-navigator",
    config = function()
        vim.keymap.set({"n", "i", "v"}, "<leader><left>", "<cmd>:TmuxNavigateLeft<CR>", OPTS)
        vim.keymap.set({"n", "i", "v"}, "<leader><right>", "<cmd>:TmuxNavigateRight<CR>", OPTS)
        vim.keymap.set({"n", "i", "v"}, "<leader><up>", "<cmd>:TmuxNavigateUp<CR>", OPTS)
        vim.keymap.set({"n", "i", "v"}, "<leader><down>", "<cmd>:TmuxNavigateDown<CR>", OPTS)
    end
}
