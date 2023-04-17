return {
    {
        'kevinhwang91/nvim-ufo',
        depencencies = {
            'kevinhwang91/promise-async'
        },
        keys = {
            { 'zR', require('ufo').openAllFolds },
            { 'zM', require('ufo').openAllFolds },
        },
        config = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            require('ufo').setup()
        end,
    },
}
