return {
    -- {
    -- replaced by go.nvim
    --     "fatih/vim-go",
    --     config = function ()
    --         vim.keymap.set("", "<C-A-l>", ":GoFmt<CR>", OPTS)
    --         vim.keymap.set("n", "<C-A-r>", ":GoRun<CR>", OPTS)
    --         vim.keymap.set("n", "<C-A-t>", ":GoTestFunc<CR>", OPTS)
    --         vim.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", OPTS)
    --         vim.keymap.set("n", "<C-S-i>", ":GoImports<CR>", OPTS)
    --     end
    -- },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("go").setup({
                lsp_cfg = {
                    capabilities = capabilities,
                }
            })

            vim.keymap.set("", "<C-A-l>", ":GoFmt<CR>", OPTS)
            vim.keymap.set("n", "<C-A-r>", ":GoRun<CR>", OPTS)
            vim.keymap.set("n", "<C-A-t>", ":GoTestFunc -v<CR>", OPTS)
            vim.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", OPTS)
            vim.keymap.set("n", "<C-S-i>", ":GoImports<CR>", OPTS)
            vim.keymap.set("n", "<C-S-/>", ":GoCmt<CR>", OPTS) -- 自动注释
            vim.keymap.set("n", "<C-S-t>", ":GoCmt<CR>", OPTS) -- 自动tags
            vim.keymap.set("n", "<C-S-A-t>", ":GoRmTag<CR>", OPTS) -- 移除tags
            vim.keymap.set("n", "q", ":GoTermClose<CR>", OPTS) -- 关闭浮动
            vim.keymap.set("n", "<C-S-A-d>", ":GoModTidy<CR>", OPTS) -- go mod tidy
            vim.keymap.set("n", "<C-A-n>", ":GoCodeAction<CR>", OPTS) -- 代码操作
            vim.keymap.set("n", "<S-t>", ":GoToggleInlay<CR>", OPTS) -- 嵌入提示
            vim.keymap.set("n", "<S-r>", ":GoGenReturn<CR>", OPTS) -- 自动return

            -- 保存时自动格式化和导入
            local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require('go.format').goimports()
                end,
                group = format_sync_grp,
            })

        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}
