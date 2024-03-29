local M = {}

function M.config()
    require("toggleterm").setup{
        shade_terminals = true
        -- shade_filetypes = { "none", "fzf" }
    }

    local trim_spaces = true
    VIM.keymap.set("v", "<space>s", function()
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = VIM.v.count })
    end)
    -- Replace with these for the other two options
    -- require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
    -- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

    -- For use as an operator map:
    -- Send motion to terminal
    VIM.keymap.set("n", [[<leader><c-\>]], function()
        set_opfunc(function(motion_type)
            require("toggleterm").send_lines_to_terminal(motion_type, false, { args = VIM.v.count })
        end)
        VIM.api.nvim_feedkeys("g@", "n", false)
    end)
    -- Double the command to send line to terminal
    VIM.keymap.set("n", [[<leader><c-\><c-\>]], function()
        set_opfunc(function(motion_type)
            require("toggleterm").send_lines_to_terminal(motion_type, false, { args = VIM.v.count })
        end)
        VIM.api.nvim_feedkeys("g@_", "n", false)
    end)
    -- Send whole file
    VIM.keymap.set("n", [[<leader><leader><c-\>]], function()
        set_opfunc(function(motion_type)
            require("toggleterm").send_lines_to_terminal(motion_type, false, { args = VIM.v.count })
        end)
        VIM.api.nvim_feedkeys("ggg@G''", "n", false)
    end)

    local opts = {buffer = 0}
    VIM.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    VIM.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    VIM.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    VIM.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    VIM.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    VIM.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    VIM.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

    laygit()
end

function laygit()
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
            VIM.cmd("startinsert!")
            VIM.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        -- function to run on closing the terminal
        on_close = function(term)
            VIM.cmd("startinsert!")
        end,
    })

    function _lazygit_toggle()
        lazygit:toggle()
    end

    VIM.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true}) 
end

return M
