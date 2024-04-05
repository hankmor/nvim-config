return {
    {
        -- snippets管理插件
        "chrisgrieser/nvim-scissors",
        dependencies = "nvim-telescope/telescope.nvim", -- optional
        config = function ()
            local snippetsDir = "~/.config/nvim/snippets/" 
            require("luasnip.loaders.from_vscode").lazy_load { paths = { snippetsDir } }
            require("scissors").setup ({
                snippetDir = snippetsDir,
            })
            vim.keymap.set("n", "<leader>se", function() 
                require("scissors").editSnippet() 
            end, OPTS)
            -- When used in visual mode prefills the selection as body.
            vim.keymap.set({ "n", "x" }, "<leader>sa", function() 
                require("scissors").addNewSnippet() 
            end, OPTS)
        end
    },
    {
        'L3MON4D3/LuaSnip', version = "v2.*", run = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function ()

            require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/snippets/"}})

            --local keymap = vim.api.nvim_set_keymap
            --local opts = { noremap = true, silent = true }
            --keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
            --keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
            --keymap("i", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
            --keymap("s", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

            local luasnip = require("luasnip")
            luasnip.config.setup({
                region_check_events = "CursorHold,InsertLeave,InsertEnter",
                delete_check_events = "TextChanged,InsertEnter",
            })
            -- require'luasnip'.filetype_extend("ruby", {"rails"})
        end
    }
}
