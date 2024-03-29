local M = {}
local snippetsDir = "~/.config/nvim/snippets/"
function M.config()
    require("luasnip.loaders.from_vscode").lazy_load { paths = { snippetsDir } }
    require("scissors").setup ({
        snippetDir = snippetsDir,
    })
    VIM.keymap.set("n", "<leader>se", function() 
        require("scissors").editSnippet() 
    end, OPTS)
    -- When used in visual mode prefills the selection as body.
    VIM.keymap.set({ "n", "x" }, "<leader>sa", function() 
        require("scissors").addNewSnippet() 
    end, OPTS)
end

return M
