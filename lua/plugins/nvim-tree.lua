local M = {}

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    vim.keymap.set('n', '<leader>-c',     api.node.navigate.parent_close,                  opts('Help'))
end

function M.config()
    -- 禁用netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- 文档树切换改为 主键 + e
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true


    -- empty setup using defaults
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
            update_cwd = false,
            update_root = true,
        },
        renderer = {
            group_empty = false,
            highlight_git = true,
            icons = {
                show = {
                    file = true,
                    folder = true,
                }
            }
        },
        filters = {
            dotfiles = true,
        },
    })
end

return M
