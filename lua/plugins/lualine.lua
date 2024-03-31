return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		-- 配置lualine状态栏
		require('lualine').setup({
			options = {
				theme = 'tokyonight'
			}
		})
	end
}
