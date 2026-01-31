local KULALA_LEADER = '<leader>k'

return {
    'mistweaverco/kulala.nvim',
    keys = {
        {
            '<leader>K',
            function()
                require('kulala').interrupt_requests()
            end,
            ft = { 'http', 'rest' },
            desc = 'Interrupt requests',
        },
        {
            KULALA_LEADER .. 'n',
            function()
                require('kulala').run()
            end,
            ft = { 'http', 'rest' },
            desc = 'Send request',
        },
        {
            KULALA_LEADER .. 'k',
            function()
                require('kulala').replay()
            end,
            desc = 'Send request',
        },
        {
            KULALA_LEADER .. 'e',
            function()
                require('kulala').set_selected_env()
            end,
            ft = { 'http', 'rest' },
            desc = 'Select environment',
        },
        {
            KULALA_LEADER .. 's',
            function()
                require('kulala').scratchpad()
            end,
            desc = 'Open scratchpad',
        },
        {
            KULALA_LEADER .. 'q',
            function()
                require('kulala').close()
            end,
            desc = 'Close Kulala',
        },
        {
            KULALA_LEADER .. 'o',
            function()
                require('kulala').open()
            end,
            desc = 'Open Kulala',
        },
        {
            KULALA_LEADER .. 't',
            function()
                require('kulala').toggle_view()
            end,
            ft = { 'http', 'rest' },
            desc = 'Toggle Header/Body',
        },
        {
            KULALA_LEADER .. 'c',
            function()
                require('kulala').copy()
            end,
            ft = { 'http', 'rest' },
            desc = 'Copy as cURL',
        },
        {
            KULALA_LEADER .. 'C',
            function()
                require('kulala').from_curl()
            end,
            ft = { 'http', 'rest' },
            desc = 'Paste from cURL',
        },
        {
            KULALA_LEADER .. 'f',
            function()
                require('kulala').search()
            end,
            ft = { 'http', 'rest' },
            desc = 'Find request',
        },
    },
    ft = { 'http', 'rest' },
    opts = {
        global_keymaps = false,
        kulala_keymaps_prefix = '',
    },
}
