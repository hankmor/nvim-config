-- 设置主键
vim.g.mapleader = " "

local function initLazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    -- 从plugins目录加载插件
    require("lazy").setup("plugins", {
        ui = {
            change_detection = {
                -- automatically check for config file changes and reload the ui
                enabled = false,
                notify = false, -- get a notification when changes are found
            },
        }
    })
end

-- init lazy
initLazy()

require("core.opt").config()
require("core.keymaps").config()
