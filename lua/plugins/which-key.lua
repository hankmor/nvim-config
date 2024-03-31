local M = {}

function M.config()
    VIM.o.timeout = true
    VIM.o.timeoutlen = 300
    require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        triggers = {"`"},
    }
end

return M
