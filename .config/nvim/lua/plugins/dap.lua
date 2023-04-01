-- TODO find some nice hotkeys
-- TODO add mason bridge
return {
    {
        'mfussenegger/nvim-dap',
        keys = { 'yod', '[od', ']od' },
        dependencies = {
            'theHamsta/nvim-dap-virtual-text',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            local dap, dapui = require('dap'), require('dapui')

            local map = require('toni.utils').map
            map('n', 'yod', require('dapui').toggle)
            map('n', '[od', require('dapui').open)
            map('n', ']od', require('dapui').close)

            -- starting and ending ui automatically
            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end,
    },
}
