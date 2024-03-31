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
        {'L3MON4D3/LuaSnip', run = "make install_jsregexp" },
        {'rafamadriz/friendly-snippets'},
        -- 自动补全
        "hrsh7th/cmp-vsnip",

        -- 显示函数签名
        { "ray-x/lsp_signature.nvim" },
        { "onsails/lspkind.nvim" },
        -- go lsp support
        -- { 'ray-x/go.nvim' },
        -- { 'ray-x/navigator.lua', requires = {
        --     { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
        --     { 'neovim/nvim-lspconfig' },
        -- }}
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" }
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

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local types = require("cmp.types")
        local str = require("cmp.utils.str")
        local lspkind = require("lspkind")

        -- nvim-cmp setup
        local cmp = require("cmp")

        local select_opts = { behavior = cmp.SelectBehavior.Select }

        local M = {}

        function cmp_config()
            cmp.setup({
                preselect = cmp.PreselectMode.None,

                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(4),
                    ["<C-l>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),

                    ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<Down>"] = cmp.mapping.select_next_item(select_opts),

                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.jumpable(1) then
                            luasnip.jump(1)
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-e>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    -- super tab GOOD! But I like tab to confirm
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {"i", "s"}),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                        elseif require("luasnip").expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
                                ""
                            )
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),

                experimental = {
                    ghost_text = false,
                },

                window = {
                    --documentation = {
                    --border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                    --},
                    completion = {
                        border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    },
                    documentation = {
                        border = "rounded",
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
                    },
                },

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                    { name = "buffer", option = { 
                        get_bufnrs = function() 
                            return vim.api.nvim_list_bufs() 
                        end, 
                    }, },
                    { name = "treesitter" },
                    { name = "calc" },
                    { name = "path" },
                    { name = "nvim_lua" },
                    { name = "spell" },
                }),

                formatting = {
                    fields = {
                        cmp.ItemField.Abbr,
                        cmp.ItemField.Kind,
                        cmp.ItemField.Menu,
                    },
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 60,
                        before = function(entry, vim_item)
                            vim_item.menu = ({
                                nvim_lsp = "ﲳ",
                                nvim_lua = "",
                                treesitter = "",
                                path = "ﱮ",
                                buffer = "﬘",
                                zsh = "",
                                luasnip = "",
                                spell = "",
                            })[entry.source.name]

                            -- Get the full snippet (and only keep first line)
                            local word = entry:get_insert_text()
                            if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                                word = vim.lsp.util.parse_snippet(word)
                            end
                            word = str.oneline(word)
                            if
                                entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
                                and string.sub(vim_item.abbr, -1, -1) == "~"
                            then
                                word = word .. "~"
                            end

                            vim_item.abbr = word

                            return vim_item
                        end,
                    }),
                },

                --enable catppuccin integration
                native_lsp = {
                    enabled = true,
                    virtual_text = {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines = {
                        errors = { "underline" },
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                },
            })
        end


        function diagnostic_config()
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = "",
                })
            end

            sign({ name = "DiagnosticSignError", text = "✘" })
            sign({ name = "DiagnosticSignWarn", text = "▲" })
            sign({ name = "DiagnosticSignHint", text = "⚑" })
            sign({ name = "DiagnosticSignInfo", text = "" })

            --Another suit of icon
            --sign({ name = "DiagnosticSignError", text = "" })
            --sign({ name = "DiagnosticSignWarn", text = "" })
            --sign({ name = "DiagnosticSignHint", text = "" })
            --sign({ name = "DiagnosticSignInfo", text = "" })

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

        function lsp_config()
            --------------------------------lspconfig-----------------------
            local lspconfig = require("lspconfig")
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

            -- Mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            local opts = { noremap = true, silent = true }
            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set({"n","i"}, "<C-k>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufopts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<space>F", function()
                    vim.lsp.buf.format({ async = true })
                end, bufopts)
            end

            local lsp_flags = {
                -- This is the default in Nvim 0.7+
                debounce_text_changes = 150,
            }

            local lsp_defaults = lspconfig.util.default_config
            lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, capabilities)

            local servers = {
                "clangd",
                "rust_analyzer",
                "pyright",
                "lua_ls",
                "cmake",
                "cssls",
                "dockerls",
                "gopls",
                "html",
                "jsonls",
                "sqlls",
                "volar",
                "yamlls",
                "quick_lint_js",
            }
            for _, lsp in pairs(servers) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    flags = lsp_flags,
                })
            end
        end

        cmp_config()

        diagnostic_config()

        lsp_config()
    end
}
