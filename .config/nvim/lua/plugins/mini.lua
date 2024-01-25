return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = 'gza',
                    delete = 'gzd',
                    replace = 'gzc',
                    highlight = 'gzh',
                    find = 'gzf',
                    find_left = 'gzF',
                    update_n_lines = 'gzn',
                },
            })

            require('mini.comment').setup()
        end,
    },
}
