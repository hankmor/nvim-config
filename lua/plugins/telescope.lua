return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
            require('telescope').setup{
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-h>"] = "which_key"
                        }
                    }
                },
                pickers = {
                    -- Default configuration for builtin pickers goes here:
                    -- picker_name = {
                    --   picker_config_key = value,
                    --   ...
                    -- }
                    -- Now the picker_config_key will be applied every time you call this
                    -- builtin picker
                },
                extensions = {
                    -- Your extension configuration goes here:
                    -- extension_name = {
                    --   extension_config_key = value,
                    -- }
                    -- please take a look at the readme of the extension you want to configure
                }
            }

            local builtin = require('telescope.builtin')

            -- 进入telescope页面会是插入模式，回到正常模式就可以用j和k来移动了
            -- pcikers
            vim.keymap.set('n', 'ff', builtin.find_files, {cwd = root}) -- 列出当前工作目录中的文件，遵循 .gitignore
            vim.keymap.set('n', 'fg', builtin.live_grep, {cwd = root})  -- 环境里要安装ripgrep
            vim.keymap.set('n', 'fb', builtin.buffers, {})   -- 列出当前 neovim 实例中打开的缓冲区buffer
            vim.keymap.set('n', 'fh', builtin.help_tags, {}) -- 搜索帮助
            vim.keymap.set('n', 'fp', builtin.planets, {})    -- 列出 planets
            vim.keymap.set('n', 'fs', builtin.grep_string, {cwd = root}) -- 在当前工作目录中的光标或所选内容下搜索字符串
            vim.keymap.set('n', 'fc', builtin.command_history, {}) -- 列出最近执行的命令
            vim.keymap.set('n', 'fcs', builtin.colorscheme, {}) -- 列出所有可用得主题

            -- lsp picker

            -- 与project.nvim插件集成打开工程管理窗口
            vim.keymap.set('n', '<leader>fp', "<cmd>lua require'telescope'.extensions.projects.projects{}<cr>", {})
            vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})	        -- Lists LSP references for word under the cursor
            vim.keymap.set('n', '<leader>ig', builtin.lsp_incoming_calls, {})	    -- Lists LSP incoming calls for word under the cursor
            vim.keymap.set('n', '<leader>og', builtin.lsp_outgoing_calls,{})	    -- Lists LSP outgoing calls for word under the cursor
            vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {})	-- Lists LSP document symbols in the current buffer
            vim.keymap.set('n', '<leader>ls', builtin.lsp_workspace_symbols, {})	-- Lists LSP document symbols in the current workspace
            vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, {})	-- Dynamically Lists LSP for all workspace symbols
            vim.keymap.set('n', '<leader>q', builtin.diagnostics, {})						-- Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
            vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})				-- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
            vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, {})					-- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
            vim.keymap.set('n', '<leader>D', builtin.lsp_type_definitions, {})			-- Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        config = function ()
            -- You dont need to set any of these options. These are the default ones. Only
            -- the loading is important
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            -- To get fzf loaded and working with telescope, you need to call
            -- load_extension, somewhere after setup function:
            require('telescope').load_extension('fzf')
        end
    }
}
