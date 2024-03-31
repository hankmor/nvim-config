local M = {}

function M.config()
    local builtin = require('telescope.builtin')

    -- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了

    VIM.keymap.set('n', 'ff', builtin.find_files, {})
    VIM.keymap.set('n', 'fg', builtin.live_grep, {})  -- 环境里要安装ripgrep
    VIM.keymap.set('n', 'fb', builtin.buffers, {})
    VIM.keymap.set('n', 'fh', builtin.help_tags, {})
    -- 与project.nvim插件集成打开工程管理窗口
    VIM.keymap.set('n', '<leader>fp', "<cmd>lua require'telescope'.extensions.projects.projects{}<cr>", {})
end

return M
