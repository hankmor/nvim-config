return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "famiu/bufdelete.nvim",
    },
    config = function ()
        require("bufferline").setup({
            options = {
                number = "none",
                --number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
                number_style = "subscript",
                modified_icon = '●', -- 修改的图标
                buffer_close_icon = '󰅖',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'icon',
                },
                max_name_length = 14,
                max_prefix_length = 13,
                tab_size = 20,
                show_buffer_close_icons = true,
                show_buffer_icons = true,
                show_tab_indicators = true,
                always_show_bufferline = true,
                separator_style = "thin",
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
            },
        })

        --按键映射
        --nnoremap <silent> gb :BufferLinePick<CR>
        vim.api.nvim_set_keymap("n", "bs", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })

        vim.api.nvim_set_keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })

        -- bufferline操作
        vim.keymap.set("n", "bn", ":BufferLineCycleNext<CR>", OPTS) -- 选择后一个
        vim.keymap.set("n", "bp", ":BufferLineCyclePrev<CR>", OPTS) -- 选择前一个
        vim.keymap.set("n", "bco", ":BufferLineCloseOthers<CR>", OPTS) -- 关闭其他
        -- vim.keymap.set("n", "bc", "bufdelete<CR>", opts) -- 关闭当前
        vim.keymap.set("n", "bc", "<cmd>lua require('bufdelete').bufdelete(0, true)<CR>", OPTS) -- 关闭当前
        vim.keymap.set("n", "bs", ":BufferLinePick<CR>", OPTS) -- 选择
    end
}
