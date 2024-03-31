return {
	"akinsho/toggleterm.nvim",
	config = function ()
		require("toggleterm").setup{
			shade_terminals = true
			-- shade_filetypes = { "none", "fzf" }
		}

		local trim_spaces = true
		vim.keymap.set("v", "<space>s", function()
			require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
		end)
		-- Replace with these for the other two options
		-- require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
		-- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

		-- For use as an operator map:
		-- Send motion to terminal
		vim.keymap.set("n", [[<leader><c-\>]], function()
			set_opfunc(function(motion_type)
				require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
			end)
			vim.api.nvim_feedkeys("g@", "n", false)
		end)
		-- Double the command to send line to terminal
		vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
			set_opfunc(function(motion_type)
				require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
			end)
			vim.api.nvim_feedkeys("g@_", "n", false)
		end)
		-- Send whole file
		vim.keymap.set("n", [[<leader><leader><c-\>]], function()
			set_opfunc(function(motion_type)
				require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
			end)
			vim.api.nvim_feedkeys("ggg@G''", "n", false)
		end)

		local opts = {buffer = 0}
		vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
		vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
		vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)


		local function laygit()
			local Terminal  = require('toggleterm.terminal').Terminal
			local lazygit = Terminal:new({ 
				cmd = "lazygit",
				hidden = true,
				dir = "git_dir",
				direction = "float",
				float_opts = {
					border = "double",
				},
				-- function to run on opening the terminal
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
				end,
				-- function to run on closing the terminal
				on_close = function(term)
					vim.cmd("startinsert!")
				end,
			})

			function _lazygit_toggle()
				lazygit:toggle()
			end

			vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true}) 
		end
		laygit()
	end
}
