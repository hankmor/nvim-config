return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        -- LSP Support
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        {'neovim/nvim-lspconfig'},             -- Required

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        { "hrsh7th/cmp-cmdline" },
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lua'},
        { "ray-x/cmp-treesitter" },
        { "f3fora/cmp-spell" },
        { "hrsh7th/cmp-calc" },

        -- Snippets
        {'L3MON4D3/LuaSnip', version = "v2.*", run = "make install_jsregexp",
             dependencies = { "rafamadriz/friendly-snippets" },
        },
        -- 自动补全
        "hrsh7th/cmp-vsnip",

        -- 显示函数签名
        { "ray-x/lsp_signature.nvim" },
        { "onsails/lspkind.nvim" },
    },

    config = function()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({buffer = bufnr})
        end)

        -- here you can setup the language servers    
        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "clangd",
                "cmake",
                "cssls",
                "gopls",
                "html",
                "jsonls",
                "quick_lint_js",
                "ltex",
                "marksman",
                "pyright",
                -- "r_language_server",
                "sqlls",
                "taplo",
                "vimls",
                "volar",
                "yamlls",
            },
            handlers = {
                lsp_zero.default_setup,
            },

            -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
            -- This setting has no relation with the `ensure_installed` setting.
            -- Can either be:
            --   - false: Servers are not automatically installed.
            --   - true: All servers set up via lspconfig are automatically installed.
            --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
            --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
            automatic_installation = true,
        })

        --------------------------------nvim-cmp------------------------
        --local capabilities = vim.lsp.protocol.make_client_capabilities()
        --capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- luasnip setup
        local luasnip = require("luasnip")
        local types = require("cmp.types")
        local str = require("cmp.utils.str")
        local lspkind = require("lspkind")
        -- nvim-cmp setup
        local cmp = require("cmp")
        local select_opts = { behavior = cmp.SelectBehavior.Select }

        local function lsp_config()
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })
        end

        local function config_lsp_signature() 
            --  config lsp signature
            local cfg = {
            }  -- add your config here
            require "lsp_signature".setup({
                bind = true, -- This is mandatory, otherwise border config won't get registered.
                handler_opts = {
                    border = "rounded"
                }
            })
            require "lsp_signature".setup(cfg)

            vim.keymap.set({ 'n', "i" }, '<C-p>', function()
                require('lsp_signature').toggle_float_win()
            end, { silent = true, noremap = true, desc = 'toggle signature' })

            vim.keymap.set({ 'n', "i" }, '<C-K>', function()
                vim.lsp.buf.signature_help()
            end, { silent = true, noremap = true, desc = 'toggle signature' })
        end

        local function cmp_config()
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                    -- completion = {
                    --     border = "rounded",
                    --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    -- },
                    -- documentation = {
                    --     border = "rounded",
                    --     winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    -- },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    { name = "treesitter" },
                    { name = "calc" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = "spell" },

                }, {
                        { name = 'buffer' },
                    })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
                }, {
                        { name = 'buffer' },
                    })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })

            -- Set up lspconfig.
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            require('lspconfig')['gopls'].setup { capabilities = capabilities }
            -- {
            --     "lua_ls",
            --     "rust_analyzer",
            --     "gopls",
            --     "html",
            --     "jsonls",
            --     "quick_lint_js",
            --     "marksman",
            --     "pyright",
            --     "sqlls",
            --     "vimls",
            --     "yamlls",
        end 

        local function diagnostic_config()
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = "",
                })
            end

            -- sign({ name = "DiagnosticSignError", text = "✘" })
            -- sign({ name = "DiagnosticSignWarn", text = "▲" })
            -- sign({ name = "DiagnosticSignHint", text = "⚑" })
            -- sign({ name = "DiagnosticSignInfo", text = "" })
            --Another suit of icon
            sign({ name = "DiagnosticSignError", text = "" })
            sign({ name = "DiagnosticSignWarn", text = "" })
            sign({ name = "DiagnosticSignHint", text = "" })
            sign({ name = "DiagnosticSignInfo", text = "" })

            vim.diagnostic.config({
                virtual_text = false,
                severity_sort = true,
                signs = true,
                update_in_insert = false,
                underline = false,
                float = {
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })
        end

        local function config_luasnip()
            -- require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").load({paths = {"~/.config/nvim/snippets/"}})
            --local keymap = vim.api.nvim_set_keymap
            --local opts = { noremap = true, silent = true }
            --keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
            --keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
            --keymap("i", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
            --keymap("s", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

            luasnip.config.setup({
                region_check_events = "CursorHold,InsertLeave,InsertEnter",
                delete_check_events = "TextChanged,InsertEnter",
            })
            -- require'luasnip'.filetype_extend("ruby", {"rails"})
        end
        lsp_config()
        cmp_config()
        diagnostic_config()
        config_lsp_signature()
        config_luasnip()
    end
}
