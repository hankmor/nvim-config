local M = {}

M.config = function ()
    local status_ok, _ = pcall(require, "project_nvim")

    if not status_ok then
        vim.notify("project_nvim not found")
    end

    require"project_nvim".setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
   }

    -- 与telescope集成
    require('telescope').load_extension('projects')
    vim.keymap.set("n", "<leader>pm", ":Telescope projects<cr>", opts)
end

return M
