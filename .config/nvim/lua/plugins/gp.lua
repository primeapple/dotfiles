return {
    'robitx/gp.nvim',
    cond = require('toni.utils').is_workstation,
    keys = {
        { 'gac', '<cmd>GpChatNew<cr>' },
        { 'gaa', '<cmd>GpChatToggle<CR>' },
        { 'gaA', '<cmd>GpChatToggle popup<CR>' },
        { 'gaf', '<cmd>GpChatFinder<CR>' },
        { 'gac', ":<C-u>'<,'>GpChatNew<CR>", mode = 'v' },
        { 'gaa', ":<C-u>'<,'>GpChatToggle<CR>", mode = 'v' },
        { 'gaA', ":<C-u>'<,'>GpChatToggle popup<CR>", mode = 'v' },
        { 'gap', ":<C-u>'<,'>GpChatPaste<CR>", mode = 'v' },
    },
    config = function()
        require('gp').setup({
            providers = {
                anthropic = {
                    disable = false,
                },
            },
        })
    end,
}
