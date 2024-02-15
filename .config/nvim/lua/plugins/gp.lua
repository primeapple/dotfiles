return {
    {
        'robitx/gp.nvim',
        event = 'VeryLazy',
        config = function()
            require('gp').setup()
        end
    }
}
