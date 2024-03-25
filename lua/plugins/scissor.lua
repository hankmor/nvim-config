local M = {}
local snippetsDir = "~/.config/nvim/snippets/"
function M.config()
    require("luasnip.loaders.from_vscode").lazy_load { paths = { snippetsDir } }
    require("scissors").setup ({
        snippetDir = snippetsDir,
    })
    vim.keymap.set("n", "<leader>se", function() 
        require("scissors").editSnippet() 
    end, opts)
    -- When used in visual mode prefills the selection as body.
    vim.keymap.set({ "n", "x" }, "<leader>sa", function() 
        require("scissors").addNewSnippet() 
    end, opts)
end

return M
