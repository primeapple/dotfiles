-- TODO: Lazy load this plugin, add keys for telescope and to switch between workspaces
return {
    {
        'nvim-neorg/neorg',
        version = '*',
        build = ':Neorg sync-parsers',
        dependencies = 'nvim-lua/plenary.nvim',
        event = 'VeryLazy',
        config = function()
            require('neorg').setup({
                load = {
                    ['core.defaults'] = {},
                    ['core.norg.concealer'] = {},
                    ['core.norg.dirman'] = {
                        config = {
                            workspaces = {
                                general = '~/Sync/notes/general',
                                goals = '~/Sync/notes/goals',
                                knowledge = '~/Sync/notes/knowledge',
                            },
                            default_workspace = 'general',
                        },
                    },
                },
            })
        end,
    },
}
