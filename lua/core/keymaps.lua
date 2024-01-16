-- 设置主键
vim.g.mapleader = " "

local km = vim.keymap

-- 插入模式


-- 视觉模式
-- 单行多行移动
km.set("v", "I", ":m '<-2<CR>gv=gv")
km.set("v", "K", ":m '>+1<CR>gv=gv")

-- 正常模式
-- 添加窗口
km.set("n", "<leader>sv", "<C-w>v") -- 增加垂直窗口
km.set("n", "<leader>sh", "<C-w>s") -- 增加水平窗口
-- 取消搜索的高亮
km.set("n", "<leader>nh", ":nohl<CR>")
