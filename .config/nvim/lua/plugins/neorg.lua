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
                    ['core.keybinds'] = {
                        config = {
                            hook = function(keybinds)
                                keybinds.map('norg', 'n', 'i', '<cmd> Neorg inject-metadata <CR>')
                                keybinds.map('norg', 'n', 'u', '<cmd> Neorg update-metadata <CR>')
                                keybinds.map('norg', 'n', 'e', '<cmd> Neorg export to-file <CR>')
                            end,
                        },
                    },
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
                    ['core.norg.completion'] = {
                        config = {
                            engine = 'nvim-cmp',
                        },
                    },
                    ['core.integrations.nvim-cmp'] = {},
                    ['core.export'] = {},
                    ['core.export.markdown'] = {},

                },
            })
        end,
    },
}
