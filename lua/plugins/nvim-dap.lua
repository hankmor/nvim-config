local M = {}
local dap = {}

function M.config()
    dap = require("dap")
    require("nvim-dap-virtual-text").setup()

    keymap()
    dapPython()
    dapGo()

end

function keymap()
    VIM.keymap.set('n', '<F5>', function() require('dap').continue() end)
    VIM.keymap.set('n', '<F8>', function() require('dap').step_over() end)
    VIM.keymap.set('n', '<F7>', function() require('dap').step_into() end)
    VIM.keymap.set('n', '<F9>', function() require('dap').step_out() end)
    VIM.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    VIM.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    VIM.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, VIM.fn.input('Log point message: ')) end)
    VIM.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    VIM.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    VIM.keymap.set("n", "<leader>dn",  "<Cmd>lua require('dap').terminate()<CR>", OPTS)
    VIM.keymap.set("n", "<M-k>",  "<Cmd>lua require('dapui').eval()<CR>", OPTS)
    VIM.keymap.set("n", "<leader>dc",  "<Cmd>lua require('dapui').close()<CR>", OPTS)
    VIM.keymap.set("n", "<leader>do",  "<Cmd>lua require('dapui').open()<CR>", OPTS)
    VIM.keymap.set("n", "<leader>dt",  "<Cmd>lua require('dapui').toggle()<CR>", OPTS)

    VIM.keymap.set({'n', 'v'}, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
    end)
    VIM.keymap.set({'n', 'v'}, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
    end)
    VIM.keymap.set('n', '<Leader>df', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.frames)
    end)
    VIM.keymap.set('n', '<Leader>ds', function()
        local widgets = require('dap.ui.widgets')
        widgets.centered_float(widgets.scopes)
    end)
end

function dapPython()
    -- python debugpy
    dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
            ---@diagnostic disable-next-line: undefined-field
            local port = (config.connect or config).port
            ---@diagnostic disable-next-line: undefined-field
            local host = (config.connect or config).host or '127.0.0.1'
            cb({
                type = 'server',
                port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                host = host,
                options = {
                    source_filetype = 'python',
                },
            })
        else
            cb({
                type = 'executable',
                command = '~/.virtualenvs/debugpy/bin/python',
                args = { '-m', 'debugpy.adapter' },
                options = {
                    source_filetype = 'python',
                },
            })
        end
    end

    dap.configurations.python = {
        {
            -- The first three options are required by nvim-dap
            type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
            request = 'launch';
            name = "Launch file";

            -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

            program = "${file}"; -- This configuration will launch the current file if used.
            pythonPath = function()
                -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                local cwd = VIM.fn.getcwd()
                if VIM.fn.executable(cwd .. '/venv/bin/python') == 1 then
                    return cwd .. '/venv/bin/python'
                elseif VIM.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                    return cwd .. '/.venv/bin/python'
                else
                    return '/usr/bin/python'
                end
            end;
        },
    }
end

function dapGo()
    -- go debug delve
    require('dap-go').setup() -- 启动 nvim-dap-go
    local dapgo = require('dap-go')
    VIM.keymap.set("n", "<leader>dt", dapgo.debug_test)
    VIM.keymap.set("n", "<leader>dl", dapgo.debug_last_test)
    dap.adapters.delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        type = 'server',
        port = '${port}',
        args = {},
        build_flags = "",
        detached = true,
        executable = {
            command = 'dlv',
            args = {'dap', '-l', '127.0.0.1:${port}'},
        }
    }
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
        {
            type = "delve",
            name = "debug wire server",
            request = "launch",
            mode = "attach",
            program = "${file}"
        },
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}"
        },
        {
            type = "delve",
            name = "debug test", -- configuration for debugging test files
            request = "launch",
            mode = "test",
            program = "${file}"
        },
        -- works with go.mod packages and sub packages 
        {
            type = "delve",
            name = "debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}"
        }
    }
end

return M
