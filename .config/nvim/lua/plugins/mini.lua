return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = 'gsa',
                    delete = 'gsd',
                    replace = 'gsc',
                    highlight = 'gsh',
                    find = 'gsf',
                    find_left = 'gsF',
                    update_n_lines = 'gsn',
                },
            })

            require('mini.comment').setup()
        end,
    },
}
