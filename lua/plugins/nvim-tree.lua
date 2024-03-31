-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true
return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local function my_on_attach(bufnr)
            local api = require "nvim-tree.api"
            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)
        end

        -- setup with some options
        require("nvim-tree").setup({
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            on_attach = my_on_attach,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                -- 文件浏览器展示位置，左侧：left, 右侧：right
                side = "left",
                -- 行号是否显示
                relativenumber = false,
                signcolumn = "yes", -- 显示图标
                width = 30,
                number = false,
                adaptive_size = true,
            },
            -- 开始重新更新目录到焦点文件
            update_focused_file = {
                enable = true,
                update_cwd = true,
                update_root = false,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                    }
                }
            },
            -- filters = {
            --     dotfiles = false,
            -- },
        })

        -- custom mappings
        vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", OPTS)
    end,
}
