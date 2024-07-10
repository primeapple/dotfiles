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
        require('gp').setup()
    end,
}
