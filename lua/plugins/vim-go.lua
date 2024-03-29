local M = {}
function M.config()
    VIM.keymap.set("", "<C-A-l>", ":GoFmt<CR>", OPTS)
    VIM.keymap.set("n", "<C-A-r>", ":GoRun<CR>", OPTS)
    VIM.keymap.set("n", "<C-A-t>", ":GoTestFunc<CR>", OPTS)
    VIM.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", OPTS)
    VIM.keymap.set("n", "<C-S-i>", ":GoImports<CR>", OPTS)
end

return M
