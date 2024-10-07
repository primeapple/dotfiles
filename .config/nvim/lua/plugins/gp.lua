return {
    'robitx/gp.nvim',
    cond = require('toni.utils').is_workstation,
    event = 'VeryLazy',
    enabled = false,
    keys = {
        -- I want GpChatToggle, GpPopup and GpChatNew in replace/vert/horizontal
        { 'ga', '<cmd>GpChatToggle <CR>', { mode = { 'n', 'x' } } },
    },
    config = function()
        require('gp').setup({
            providers = {
                anthropic = {
                    endpoint = 'https://api.anthropic.com/v1/messages',
                    secret = os.getenv('ANTHROPIC_API_KEY'),
                    disable = false,
                },
            },
        })
    end,
}
