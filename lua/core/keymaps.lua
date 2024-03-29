OPTS = {noremap = true, silent = true}

local M = {}

function M.config()
    -- 设置主键
    VIM.g.mapleader = " "

    local km = VIM.keymap
    VIM.api.nvim_set_keymap('n', '<leader>r', ':luafile $MYVIMRC<CR>', OPTS)

    -- 单行多行移动
    km.set("v", "K", ":m '<-2<CR>gv=gv", OPTS)
    km.set("v", "J", ":m '>+1<CR>gv=gv", OPTS)

    -- 快速移动
    -- km.set("n", "J", "5j", opts)
    -- km.set("n", "K", "5k", opts)
    km.set("n", "H", "^", OPTS)
    km.set("n", "L", "$", OPTS)

    km.set("n", "<M-s>", ":w<CR>", OPTS)

    -- 定义空位可以跳转
    km.set("n", "<leader><leader>", "<Esc>/<++><CR>:nohlsearch<CR>4xi", OPTS)
    km.set("n", "<leader>sc", ":set spell!<cr>", OPTS)
    km.set("n", "<leader>sw", ":set wrap!<cr>", OPTS) -- 是否换行切换

    -- 替换高亮
    km.set("v", "p", '"_dP', OPTS)

    ---- 添加窗口 ----
    km.set("n", "<leader>sv", "<C-w>v", OPTS) -- 增加垂直窗口
    km.set("n", "<leader>sh", "<C-w>s", OPTS) -- 增加水平窗口
    km.set("n", "sv", "<C-w>t<C-w>H", OPTS)
    km.set("n", "sh", "<C-w>t<C-w>K", OPTS)
    km.set("n", "srh", "<C-w>b<C-w>K", OPTS) -- 切换为水平分隔窗口
    km.set("n", "srv", "<C-w>b<C-w>H", OPTS) -- 切换为垂直分隔窗口
    -- 调整窗口大小
    km.set("n", "<S-up>", ":res -5<cr>", OPTS)
    km.set("n", "<S-down>", ":res +5<cr>", OPTS)
    km.set("n", "<S-left>", ":vertical resize+5<cr>", OPTS)
    km.set("n", "<S-right>", ":vertical resize-5<cr>", OPTS)

    ---- 取消搜索的高亮 ----
    km.set("n", "<leader>nh", ":nohl<CR>", OPTS)

    km.set({"n", "x"}, "<F3>", ":q<CR>", OPTS)
    km.set({"n", "x"}, "<F2>", ":w<CR>", OPTS)
    -- km.set({"n", "x"}, "<F3>", ":wq<CR>", opts)

    -- 格式化代码
    km.set("n", "<leader>f", ":Neoformat<CR>", OPTS)
    km.set("n", "<<", ":<<CR>", OPTS)
    km.set("n", ">>", ":><CR>", OPTS)

    -- 翻页
    km.set("n", "<C-u>", "10k", OPTS)
    km.set("n", "<C-d>", "10j", OPTS)

    -- 撤销
    km.set({"n", "x"}, "<M-z>", ":u<cr>", OPTS)

    -- Move text up and down
    -- mac 中 M 为 option，windows下为 A
    km.set("n", "<M-up>", ":m .-2<CR>", OPTS)
    km.set("n", "<M-down>", ":m .+1<CR>", OPTS)
    km.set("v", "<M-down>", ":m '>+1<CR>gv=gv", OPTS)
    km.set("v", "<M-up>", ":m '<-2<CR>gv=gv", OPTS)

    -- dashboard
    km.set("n", "<leader>db", ":Dashboard<CR>", OPTS)

    -- git
    km.set("n", "<leader>gt", ":Git<CR>", OPTS)
    km.set("n", "<leader>gp", ":Git push<CR>", OPTS)
    km.set("n", "<leader>gs", ":Git status<CR>", OPTS)
    km.set("n", "<leader>gl", ":Git pull<CR>", OPTS)
    km.set("n", "<leader>ga", ":Git add .<CR>", OPTS)
    km.set("n", "<leader>gc", ":Git commit -m", OPTS)

    -- codes
    km.set("", "<M-/>", ":gcc<CR>", OPTS)
end

return M
