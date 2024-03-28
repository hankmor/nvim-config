local M = {}

function M.config()
    local cfg = {
    }  -- add your config here
    require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded"
        }
    })
    require "lsp_signature".setup(cfg)

    vim.keymap.set({ 'n', "i" }, '<C-k>', function()       require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, desc = 'toggle signature' })

    vim.keymap.set({ 'n', "i" }, '<C-K>', function()
        vim.lsp.buf.signature_help()
    end, { silent = true, noremap = true, desc = 'toggle signature' })

end

return M
