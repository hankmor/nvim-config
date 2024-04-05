return {
	-- 优化 vim  自身UI
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
	-- 主题
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require('tokyonight').setup()
		end
		-- vim.cmd[[colorscheme tokyonight]]
	},
	{
		'projekt0n/github-nvim-theme',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('github-theme').setup({
				-- ...
			})
			vim.cmd('colorscheme github_dark')
		end,
	}
}
