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
            sync_root_with_cwd = false,
            respect_buf_cwd = false,
            on_attach = my_on_attach,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                -- 文件浏览器展示位置，左侧：left, 右侧：right
                side = "left",
                -- 行号是否显示
                relativenumber = true,
                signcolumn = "yes", -- 显示图标
                width = 30,
                number = true,
                adaptive_size = false,
            },
            -- 开始重新更新目录到焦点文件
            update_focused_file = {
                enable = false,
                update_cwd = false,
                update_root = false,
                ignore_list = {},
                exclude = false,
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                    }
                },
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", ".gitignore"}
            },
            filters = {
                dotfiles = false,
            },
        })

        -- custom mappings
        vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", OPTS)
        vim.keymap.set("n", "<leader>o", ":NvimTreeFindFile<CR>", OPTS)
    end,
}
