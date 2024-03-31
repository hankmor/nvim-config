return {
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
}