local M = {}

function M.config()
    require('undotree').setup({
    })

    VIM.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })
    -- or
    VIM.keymap.set('n', '<leader>uo', require('undotree').open, { noremap = true, silent = true })
    VIM.keymap.set('n', '<leader>uc', require('undotree').close, { noremap = true, silent = true })
end

return M
