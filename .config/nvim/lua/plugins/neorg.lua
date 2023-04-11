return {
    {
        'nvim-neorg/neorg',
        version = '*',
        build = ':Neorg sync-parsers',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
        ft = 'norg',
        cmd = 'Neorg',
        keys = {
            { '<leader>N', '<cmd>Neorg <CR>' },
            { '<leader>nn', '<cmd>Neorg workspace notes <CR>' },
            { '<leader>ng', '<cmd>Neorg workspace goals <CR>' },
            { '<leader>nk', '<cmd>Neorg workspace knowledge <CR>' },
        },
        event = 'VeryLazy',
        config = function()
            require('neorg').setup({
                load = {
                    ['core.defaults'] = {},
                    ['core.norg.concealer'] = {},
                    ['core.norg.dirman'] = {
                        config = {
                            workspaces = {
                                notes = '~/Sync/notes/notes',
                                goals = '~/Sync/notes/goals',
                                knowledge = '~/Sync/notes/knowledge',
                            },
                            default_workspace = 'notes',
                        },
                    },
                    ['core.integrations.treesitter'] = {},
                    ['core.export.markdown'] = {},
                },
            })
        end,
    },
}
