-- 开启终端真颜色
vim.opt.termguicolors = true

require("bufferline").setup {
    options = {
        modified_icon = '●', -- 修改的图标
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