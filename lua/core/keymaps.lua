-- 设置主键
vim.g.mapleader = " "

local km = vim.keymap

vim.api.nvim_set_keymap('n', '<leader>r', ':luafile $MYVIMRC<CR>', {noremap = true, silent = true})

-- 插入模式


-- 视觉模式
-- 单行多行移动
km.set("v", "J", ":m '<-2<CR>gv=gv")
km.set("v", "K", ":m '>+1<CR>gv=gv")

-- -------- 正常模式 --------

-- ---- 添加窗口 ----
-- 主键 + sv 增加垂直窗口
-- 主键 + sh 增加水平窗口
km.set("n", "<leader>sv", "<C-w>v") -- 增加垂直窗口
km.set("n", "<leader>sh", "<C-w>s") -- 增加水平窗口
-- ---- 取消搜索的高亮 ----
-- 主键 + nh
km.set("n", "<leader>nh", ":nohl<CR>")

-- ---- 插件改建 ----

-- 文档树切换改为 主键 + e
km.set("n", "<leader>e", ":NvimTreeToggle<CR>")
-- 退出改为主键 + q
km.set("n", "<leader>q", ":q<CR>")
km.set("n", "<leader>s", ":w<CR>")
--
-- bufferline操作
km.set("n", "bn", ":BufferLineCycleNext<CR>") -- 选择后一个
km.set("n", "bp", ":BufferLineCyclePrev<CR>") -- 选择前一个
km.set("n", "bco", ":BufferLineCloseOthers<CR>") -- 关闭其他
km.set("n", "bc", ":BufferLineDelete<CR>") -- 删除
km.set("n", "bs", ":BufferLinePick<CR>") -- 选择

-- 格式化代码
km.set("n", "<leader>f", ":Neoformat<CR>")
km.set("n", "<<", ":<<CR>")
km.set("n", ">>", ":><CR>")

-- 翻页
km.set("n", "<C-u>", "10k")
km.set("n", "<C-d>", "10j")
