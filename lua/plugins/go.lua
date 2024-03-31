return {
    "fatih/vim-go",
    config = function ()
        vim.keymap.set("", "<C-A-l>", ":GoFmt<CR>", OPTS)
        vim.keymap.set("n", "<C-A-r>", ":GoRun<CR>", OPTS)
        vim.keymap.set("n", "<C-A-t>", ":GoTestFunc<CR>", OPTS)
        vim.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", OPTS)
        vim.keymap.set("n", "<C-S-i>", ":GoImports<CR>", OPTS)
    end
}
