return {
    'folke/sidekick.nvim',
    opts = {
        nes = { enabled = false },
        cli = {
            win = { layout = 'float' },
        },
    },
    keys = {
        {
            '<c-.>',
            function()
                require('sidekick.cli').toggle({ filter = { installed = true } })
            end,
            desc = 'Sidekick Toggle',
            mode = { 'n', 't', 'i', 'x' },
        },
        {
            '<leader>aa',
            function()
                require('sidekick.cli').toggle({ filter = { installed = true } })
            end,
            desc = 'Sidekick Toggle CLI',
        },
        {
            '<leader>ad',
            function()
                require('sidekick.cli').close()
            end,
            desc = 'Detach a CLI Session',
        },
        {
            '<leader>at',
            function()
                require('sidekick.cli').send({ filter = { installed = true }, msg = '{this}' })
            end,
            mode = { 'x', 'n' },
            desc = 'Send This',
        },
        {
            '<leader>af',
            function()
                require('sidekick.cli').send({ filter = { installed = true }, msg = '{file}' })
            end,
            desc = 'Send File',
        },
        {
            '<leader>av',
            function()
                require('sidekick.cli').send({ filter = { installed = true }, msg = '{selection}' })
            end,
            mode = { 'x' },
            desc = 'Send Visual Selection',
        },
        {
            '<leader>ap',
            function()
                require('sidekick.cli').prompt()
            end,
            mode = { 'n', 'x' },
            desc = 'Sidekick Select Prompt',
        },
    },
}
