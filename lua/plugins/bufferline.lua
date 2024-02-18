-- 开启终端真颜色
vim.opt.termguicolors = true

require("bufferline").setup {
    options = {
        modified_icon = '●', -- 修改的图标
        buffer_close_icon = '󰅖',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },

        numbers = "ordinal",
        color_icons = true,
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
        }}
    }
}
