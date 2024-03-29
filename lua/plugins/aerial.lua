local M = {}

M.config = function ()
    local aerial_ok, aerial = pcall(require, "aerial")
    if not aerial_ok then
        return
    end

    require'aerial'.setup {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function()
            -- Jump forwards/backwards with '{' and '}'
            VIM.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            VIM.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            -- You probably also want to set a keymap to toggle aerial
            VIM.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
        end,
    }
    require("telescope").load_extension("aerial")
end
return M
