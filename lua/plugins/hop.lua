return {
	"phaazon/hop.nvim", branch = 'v2',
	config = function ()
		require('hop').setup {
			keys = 'etovxqpdygfblzhckisuran',
		}

		vim.api.nvim_set_keymap('', 'ss', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
		vim.api.nvim_set_keymap('', 'sS', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
	end
}
