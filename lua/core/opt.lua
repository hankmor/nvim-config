local opt = vim.opt

-- 行号
opt.relativenumber = true -- 显示相对行号
opt.number = true -- 开启行号显示

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- 防止包裹
opt.wrap = false

-- 光标行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

-- 启用系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口位置
opt.splitright = true
opt.splitbelow = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true

-- 外观
opt.termguicolors = true -- 终端真颜色
opt.signcolumn = "yes" -- 左侧多一列用于debug等
vim.cmd[[colorscheme tokyonight-night]]
