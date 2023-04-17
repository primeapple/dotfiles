return {
    {
        'kevinhwang91/nvim-ufo',
        event = 'VeryLazy',
        dependencies = {
            'kevinhwang91/promise-async',
        },
        keys = {
            { 'zR',               '<cmd>lua require("ufo").openAllFolds() <CR>' },
            { 'zM',               '<cmd>lua require("ufo").closeAllFolds() <CR>' },
            { '<leader><leader>', 'zA' },
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
