local M = {}
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

-- local packer_bootstrap = ensure_packer()

-- 自动安装插件，而不是执行 packer sync
-- vim.cmd([[
--   augroup packer_user_config
--   autocmd!
--   autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

M.config = function ()
    require('packer').startup(function(use)
        -- 图标
        use {'nvim-tree/nvim-web-devicons'}

        use 'wbthomason/packer.nvim'
        -- My plugins here
        use 'folke/tokyonight.nvim' -- 主题  
        use {
            'nvim-lualine/lualine.nvim',  -- 状态栏
            requires = { 'kyazdani42/nvim-web-devicons', opt = true }  -- 状态栏图标
        }

        use {
            'nvim-tree/nvim-tree.lua',  -- 文档树
            requires = {
                'nvim-tree/nvim-web-devicons', -- 文档树图标, 需要终端字体改为 nerdfont，见 nerdfonts.com
            }
        }
        -- 项目管理
        use { "ahmedkhalf/project.nvim", }

        -- 用ctrl-hjkl来切换不同窗口
        use "christoomey/vim-tmux-navigator"

        use "nvim-treesitter/nvim-treesitter" -- 语法高亮
        use "p00f/nvim-ts-rainbow" -- 配合treesitter，不同括号颜色区分

        -- 语法提示 lsp
        use({ "williamboman/mason.nvim" })
        use({ "williamboman/mason-lspconfig.nvim" })
        use({ "neovim/nvim-lspconfig" })
        use({ "hrsh7th/nvim-cmp" }) -- Autocompletion plugin
        use({ "hrsh7th/cmp-nvim-lsp" }) -- LSP source for nvim-cmp
        use({ "hrsh7th/cmp-buffer" })
        use({ "hrsh7th/cmp-path" }) -- 补全文件路径
        use({ "hrsh7th/cmp-cmdline" })
        use({ "hrsh7th/cmp-nvim-lua" })
        use({ "f3fora/cmp-spell" })
        use({ "hrsh7th/cmp-calc" })
        use({ "saadparwaiz1/cmp_luasnip" }) -- Snippets source for nvim-cmp
        use({
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!:).
            run = "make install_jsregexp"
        })
        use({ "rafamadriz/friendly-snippets" })
        use({ "ray-x/cmp-treesitter" })
        use({ "onsails/lspkind.nvim" })

        -- languages
        use({ "mfussenegger/nvim-dap" })
        use({ "theHamsta/nvim-dap-virtual-text" })
        use({ "rcarriga/nvim-dap-ui" })

        use({ "olexsmir/gopher.nvim" })
        use({ "leoluz/nvim-dap-go" })

        -- 自动补全
        use "hrsh7th/cmp-vsnip"
        use "numToStr/Comment.nvim" -- gcc和gc注释
        use "windwp/nvim-autopairs" -- 自动补全括号

        use "akinsho/bufferline.nvim" -- buffer分割线
        use 'famiu/bufdelete.nvim' -- buffer窗口关闭插件
        use "lewis6991/gitsigns.nvim" -- 左则git提示

        use 'ethanholz/nvim-lastplace' -- 打开文件时回到上次的光标位置
        -- 快速搜索字符
        use {
            'phaazon/hop.nvim',
            branch = 'v2', -- optional but strongly recommended
        }
        -- 格式化代码
        use 'sbdchd/neoformat'

        -- 更改包裹字符
        use ({"kylechui/nvim-surround", tab = "*", config = function ()
            require("nvim-surround").setup({
            })
        end})

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.5',  -- 文件检索
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        -- 显示代码的函数列表
        use({ "stevearc/aerial.nvim", })

        -- markdown预览
        -- install without yarn or npm
        use({ "iamcco/markdown-preview.nvim" })

        -- fugitive 集成git
        use({ "tpope/vim-fugitive" })

        -- 启动界面
        use {
            'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            requires = {'nvim-tree/nvim-web-devicons'}
        }

        -- 从剪贴板粘贴图片
        use 'ekickx/clipboard-image.nvim'

        -- asciidoc预览插件
        use({
            'tigion/nvim-asciidoc-preview',
            run = 'cd server && npm install',
        })

        -- 直接在代码中显示语法错误
        -- use {'dense-analysis/ale'}
        use({
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
            end,
        })

        -- go扩展插件
        use {'fatih/vim-go'}

        -- snippets管理插件
        use {
            "chrisgrieser/nvim-scissors",
            dependencies = "nvim-telescope/telescope.nvim", -- optional
        }

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
            -- require('packer').sync()
        end
    end)
end

return M
