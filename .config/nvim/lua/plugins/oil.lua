return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        dependencies = {
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require('oil').setup({
                keymaps = {
                    ['<C-/>'] = 'actions.select_vsplit',
                    ['<C-->'] = 'actions.select_split',
                },
            })
            local map = require('toni.utils').map
            map('n', '-', require('oil').open)
        end,
    },
}
