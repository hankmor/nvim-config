local M = {}
function M.config()
    -- 配置lualine状态栏
    require('lualine').setup({
        options = {
            theme = 'tokyonight'
        }
    })
end
return M
