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

    VIM.keymap.set({ 'n', "i" }, '<C-p>', function()       require('lsp_signature').toggle_float_win()
    end, { silent = true, noremap = true, desc = 'toggle signature' })

    VIM.keymap.set({ 'n', "i" }, '<C-K>', function()
        VIM.lsp.buf.signature_help()
    end, { silent = true, noremap = true, desc = 'toggle signature' })

end

return M
