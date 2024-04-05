return {
    "ahmedkhalf/project.nvim",
    config = function ()
        require("project_nvim").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below

        }
        -- 与telescope集成
        require('telescope').load_extension('projects')
        -- 与project.nvim插件集成打开工程管理窗口
        vim.keymap.set("n", "<leader>pm", ":Telescope projects<cr>", OPTS)
    end
}
