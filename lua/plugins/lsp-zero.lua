local M = {}

function M.config()
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
end

return M

