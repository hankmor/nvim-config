OPTS = {noremap = true, silent = true}

local M = {}

function M.config()
    vim.api.nvim_set_keymap('n', '<leader>r', ':luafile $MYVIMRC<CR>', OPTS)

    -- 单行多行移动
    vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", OPTS)
    vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", OPTS)

    -- 快速移动
    -- vim.keymap.set("n", "J", "5j", opts)
    -- vim.keymap.set("n", "K", "5k", opts)
    vim.keymap.set("n", "H", "^", OPTS)
    vim.keymap.set("n", "L", "$", OPTS)

    vim.keymap.set("n", "<M-s>", ":w<CR>", OPTS)

    -- 定义空位可以跳转
    vim.keymap.set("n", "<leader><leader>", "<Esc>/<++><CR>:nohlsearch<CR>4xi", OPTS)
    vim.keymap.set("n", "<leader>sc", ":set spell!<cr>", OPTS)
    vim.keymap.set("n", "<leader>sw", ":set wrap!<cr>", OPTS) -- 是否换行切换

    -- 替换高亮
    vim.keymap.set("v", "p", '"_dP', OPTS)

    ---- 添加窗口 ----
    vim.keymap.set("n", "<leader>sv", "<C-w>v", OPTS) -- 增加垂直窗口
    vim.keymap.set("n", "<leader>sh", "<C-w>s", OPTS) -- 增加水平窗口
    vim.keymap.set("n", "sv", "<C-w>t<C-w>H", OPTS)
    vim.keymap.set("n", "sh", "<C-w>t<C-w>K", OPTS)
    vim.keymap.set("n", "srh", "<C-w>b<C-w>K", OPTS) -- 切换为水平分隔窗口
    vim.keymap.set("n", "srv", "<C-w>b<C-w>H", OPTS) -- 切换为垂直分隔窗口
    -- 调整窗口大小
    vim.keymap.set("n", "<S-up>", ":res -5<cr>", OPTS)
    vim.keymap.set("n", "<S-down>", ":res +5<cr>", OPTS)
    vim.keymap.set("n", "<S-left>", ":vertical resize+5<cr>", OPTS)
    vim.keymap.set("n", "<S-right>", ":vertical resize-5<cr>", OPTS)

    ---- 取消搜索的高亮 ----
    vim.keymap.set("n", "<leader>nh", ":nohl<CR>", OPTS)

    vim.keymap.set({"n", "x"}, "wq", ":q<CR>", OPTS)
    vim.keymap.set({"n", "x"}, "we", ":w<CR>", OPTS)
    -- vim.keymap.set({"n", "x"}, "<F3>", ":wq<CR>", opts)

    -- 格式化代码
    vim.keymap.set("n", "<leader>f", ":Neoformat<CR>", OPTS)
    vim.keymap.set("n", "<<", ":<<CR>", OPTS)
    vim.keymap.set("n", ">>", ":><CR>", OPTS)

    -- 翻页
    vim.keymap.set("n", "<M-d>", "10k", OPTS)
    vim.keymap.set("n", "<M-f>", "10j", OPTS)

    -- 撤销
    vim.keymap.set({"n", "x"}, "<M-z>", ":u<cr>", OPTS)

    -- Move text up and down
    -- mac 中 M 为 option，windows下为 A
    vim.keymap.set("n", "<M-up>", ":m .-2<CR>", OPTS)
    vim.keymap.set("n", "<M-down>", ":m .+1<CR>", OPTS)
    vim.keymap.set("v", "<M-down>", ":m '>+1<CR>gv=gv", OPTS)
    vim.keymap.set("v", "<M-up>", ":m '<-2<CR>gv=gv", OPTS)

    -- dashboard
    vim.keymap.set("n", "<leader>db", ":Dashboard<CR>", OPTS)

    -- git
    vim.keymap.set("n", "<leader>gt", ":Git<CR>", OPTS)
    vim.keymap.set("n", "<leader>gp", ":Git push<CR>", OPTS)
    vim.keymap.set("n", "<leader>gs", ":Git status<CR>", OPTS)
    vim.keymap.set("n", "<leader>gl", ":Git pull<CR>", OPTS)
    vim.keymap.set("n", "<leader>ga", ":Git add .<CR>", OPTS)
    vim.keymap.set("n", "<leader>gc", ":Git commit -m", OPTS)
end

return M
