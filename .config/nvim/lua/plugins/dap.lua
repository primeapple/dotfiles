-- TODO: find some nice hotkeys
return {
    {
        'mfussenegger/nvim-dap',
        -- TODO use keys
        event = 'VeryLazy',
        -- keys = { 'yod', '[od', ']od' },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'mxsdev/nvim-dap-vscode-js',
        },
        config = function()
            local dap, dapui, widgets = require('dap'), require('dapui'), require('dap.ui.widgets')
            local map = require('toni.utils').map

            map('n', '<leader>uu', function()
                dap.continue()
            end)
            map('n', '<leader>uo', function()
                dap.step_over()
            end)
            map('n', '<leader>ui', function()
                dap.step_into()
            end)
            map('n', '<leader>ux', function()
                dap.step_out()
            end)
            map('n', '<leader>U', function()
                dap.toggle_breakpoint()
            end)
            map('n', '<leader>up', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end)
            map('n', '<leader>ur', function()
                dap.repl.open()
            end)
            map('n', '<leader>ul', function()
                dap.run_last()
            end)
            map({ 'n', 'v' }, '<leader>uh', function()
                require('dap.ui.widgets').hover()
            end)
            map({ 'n', 'v' }, '<leader>up', function()
                require('dap.ui.widgets').preview()
            end)
            map('n', '<leader>uf', function()
                widgets.centered_float(widgets.frames)
            end)
            map('n', '<leader>us', function()
                widgets.centered_float(widgets.scopes)
            end)

            require('dapui').setup()
            map('n', 'yod', require('dapui').toggle)
            map('n', '[od', require('dapui').open)
            map('n', ']od', require('dapui').close)

            -- starting and ending ui automatically
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            require('dap-vscode-js').setup({
                debugger_path = vim.fn.stdpath('data') .. '/mason/bin/chrome-debug-adapter',
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
            })
        end,
    },
}
