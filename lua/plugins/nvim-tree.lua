-- 禁用netrw 
vim.g.loaded_netrw = 1 
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    -- 文件浏览器展示位置，左侧：left, 右侧：right
	side = "left",
	-- 行号是否显示
	number = false,
	relativenumber = false,
	signcolumn = "yes", -- 显示图标
    width = 30,
    number = false,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = true,
  },
})
