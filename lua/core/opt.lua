local M = {}

function M.config()
    local opt = VIM.opt
    local cmd = VIM.cmd

    -- basics
    cmd("syntax on")
    cmd("filetype plugin indent on")
    cmd("nohlsearch")
    opt.shiftround = true
    opt.updatetime = 100

    -- 行号
    opt.relativenumber = true -- 显示相对行号
    opt.number = true -- 开启行号显示

    -- 防止包裹
    opt.wrap = true

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
    opt.hlsearch = true
    opt.incsearch = true
    opt.smartcase = true
    opt.showmatch = true

    -- 外观
    opt.termguicolors = true -- 终端真颜色
    opt.signcolumn = "yes" -- 左侧多一列用于debug等
    cmd[[colorscheme tokyonight-night]]

    -- tab
    opt.autoindent = true
    opt.tabstop = 4
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.expandtab = true
    opt.cindent = true
    opt.smartindent = true

    opt.list = true
    opt.listchars = {
        tab = "▸ ",
        trail = "▫",
    }
    VIM.opt.mouse = "a"
    VIM.opt.encoding = "utf-8"
    --vim.opt.guifont = "Cascadia_Code_PL:h12"
    -- vim.opt.guifont = 'DejaVu_Sans_Mono_Font'
    -- vim.opt.guifont = 'Fira_Code_Font'

    opt.autowrite = true
    opt.formatoptions = ""
    opt.scrolloff = 10 -- 向下滚动时留指定行
    opt.tw = 0
    opt.backspace = "indent,eol,start"
    opt.foldmethod = "indent"
    opt.foldlevel = 99
    opt.laststatus = 2
    opt.autochdir = true
    opt.clipboard = "unnamedplus"
    opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
    opt.conceallevel = 0 -- so that `` is visible in markdown files
    opt.lazyredraw = false
    opt.compatible = false
    opt.shell = "/bin/bash"
    opt.signcolumn = "yes"
    opt.swapfile = false
    opt.backup = false
    opt.writebackup = false

    opt.shortmess:append({ c = true })
    opt.whichwrap:append({ ["<"] = true, [">"] = true, [","] = true, h = true, l = true })
    cmd([[set iskeyword+=-]]) -- 将连字符 - 的单词是为一个

    -- presistent undo
    VIM.bo.undofile = true
    opt.undodir = VIM.fn.expand("~/.config/nvim/.tmp/undo")

    opt.spell = true
    opt.spelllang = { "en_us" }

    -- Disables automatic commenting on newline
    VIM.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "*" },
        command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
    })

    -- Highlight yanked text
    local au = VIM.api.nvim_create_autocmd
    local ag = VIM.api.nvim_create_augroup
    -- Highlight the texts when you yanked
    au("TextYankPost", {
        group = ag("yank_highlight", {}),
        pattern = "*",
        callback = function()
            VIM.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
        end,
    })
end
return M
