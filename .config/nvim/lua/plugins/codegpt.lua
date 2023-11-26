return {
    {
        'dpayne/CodeGPT.nvim',
        -- also `tiktoken` should be installed
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        event = 'VeryLazy',
        config = function()
            require('codegpt.config')
        end,
    },
}
