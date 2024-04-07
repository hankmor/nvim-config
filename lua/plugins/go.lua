return {
    -- {
        -- replaced by go.nvim
        -- "fatih/vim-go",
        -- config = function ()
        --     vim.keymap.set("", "<C-A-l>", ":GoFmt<CR>", OPTS)
        --     vim.keymap.set("n", "<C-A-r>", ":GoRun<CR>", OPTS)
        --     vim.keymap.set("n", "<C-A-t>", ":GoTestFunc<CR>", OPTS)
        --     vim.keymap.set("n", "<C-A-i>", ":GoImpl<CR>", OPTS)
        --     vim.keymap.set("n", "<C-S-i>", ":GoImports<CR>", OPTS)
        -- end
    -- },
    {
        -- more powerful go support plugin 
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require("go").setup({
                lsp_keymaps = true,
                lsp_cfg = {
                    capabilities = capabilities,
                },
                -- 内连提示
                lsp_inlay_hints = {
                    enable = false,
                    -- hint style, set to 'eol' for end-of-line hints, 'inlay' for inline hints
                    -- inlay only avalible for 0.10.x
                    style = 'inlay',
                    -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
                    -- Only show inlay hints for the current line
                    only_current_line = false,
                    -- Event which triggers a refersh of the inlay hints.
                    -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                    -- not that this may cause higher CPU usage.
                    -- This option is only respected when only_current_line and
                    -- autoSetHints both are true.
                    only_current_line_autocmd = "CursorHold",
                    -- whether to show variable name before type hints with the inlay hints or not
                    -- default: false
                    show_variable_name = true,
                    -- prefix for parameter hints
                    parameter_hints_prefix = "󰊕 ",
                    show_parameter_hints = true,
                    -- prefix for all the other hints (type, chaining)
                    other_hints_prefix = "=> ",
                    -- whether to align to the lenght of the longest line in the file
                    max_len_align = false,
                    -- padding from the left if max_len_align is true
                    max_len_align_padding = 1,
                    -- whether to align to the extreme right or not
                    right_align = false,
                    -- padding from the right if right_align is true
                    right_align_padding = 6,
                    -- The color of the hints
                    highlight = "Comment",
                },
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
