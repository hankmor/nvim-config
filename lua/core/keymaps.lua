-- 设置主键
vim.g.mapleader = " "

local km = vim.keymap
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<leader>r', ':luafile $MYVIMRC<CR>', opts)

-- 单行多行移动
km.set("v", "J", ":m '<-2<CR>gv=gv", opts)
km.set("v", "K", ":m '>+1<CR>gv=gv", opts)

-- 快速移动
km.set("n", "J", "5j", opts)
km.set("n", "K", "5k", opts)
km.set("n", "H", "0", opts)
km.set("n", "L", "$", opts)

km.set("n", "<M-s>", ":w<CR>", opts)

-- 定义空位可以跳转
km.set("n", "<leader><leader>", "<Esc>/<++><CR>:nohlsearch<CR>4xi", opts)
km.set("n", "<leader>sc", ":set spell!<cr>", opts)
km.set("n", "<leader>sw", ":set wrap!<cr>", opts) -- 是否换行切换

-- 替换高亮
km.set("v", "p", '"_dP', opts)

---- 添加窗口 ----
-- 主键 + sv 增加垂直窗口
-- 主键 + sh 增加水平窗口
km.set("n", "<leader>sv", "<C-w>v", opts) -- 增加垂直窗口
km.set("n", "<leader>sh", "<C-w>s", opts) -- 增加水平窗口
km.set("n", "sv", "<C-w>t<C-w>H", opts) 
km.set("n", "sh", "<C-w>t<C-w>K", opts)
km.set("n", "srh", "<C-w>b<C-w>K", opts) -- 切换为水平分隔窗口
km.set("n", "srv", "<C-w>b<C-w>H", opts) -- 切换为垂直分隔窗口
-- 调整窗口大小
km.set("n", "<up>", ":res -5<cr>", opts)
km.set("n", "<down>", ":res +5<cr>", opts)
km.set("n", "<left>", ":ertical resize-5<cr>", opts)
km.set("n", "<right>", ":vertical resize+5<cr>", opts)

---- 取消搜索的高亮 ----
-- 主键 + nh
km.set("n", "<leader>nh", ":nohl<CR>", opts)

---- 插件改建 ----
-- 文档树切换改为 主键 + e
km.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- 退出改为主键 + q
km.set("n", "<leader>q", ":q<CR>", opts)
km.set("n", "<leader>s", ":w<CR>", opts)

-- bufferline操作
km.set("n", "bn", ":BufferLineCycleNext<CR>", opts) -- 选择后一个
km.set("n", "bp", ":BufferLineCyclePrev<CR>", opts) -- 选择前一个
km.set("n", "bco", ":BufferLineCloseOthers<CR>", opts) -- 关闭其他
-- km.set("n", "bc", ":BufferLineDelete<CR>", opts) -- 删除
km.set("n", "bc", ":bdelete! %d<CR>", opts) -- 关闭当前
km.set("n", "bs", ":BufferLinePick<CR>", opts) -- 选择

-- 格式化代码
km.set("n", "<leader>f", ":Neoformat<CR>", opts)
km.set("n", "<<", ":<<CR>", opts)
km.set("n", ">>", ":><CR>", opts)

-- 翻页
km.set("n", "<C-u>", "10k", opts)
km.set("n", "<C-d>", "10j", opts)

-- Move text up and down
-- mac 中 M 为 option，windows下为 A
km.set("n", "<M-up>", ":m .-2<CR>", opts)
km.set("n", "<M-down>", ":m .+1<CR>", opts)
km.set("v", "<M-down>", ":m '>+1<CR>gv=gv", opts)
km.set("v", "<M-up>", ":m '<-2<CR>gv=gv", opts)

-- git
km.set("n", "<leader>gt", ":Git<CR>", opts)
km.set("n", "<leader>gp", ":Git push<CR>", opts)
km.set("n", "<leader>gs", ":Git status<CR>", opts)
km.set("n", "<leader>gl", ":Git pull<CR>", opts)
km.set("n", "<leader>ga", ":Git add .<CR>", opts)
km.set("n", "<leader>gc", ":Git commit -m", opts)
