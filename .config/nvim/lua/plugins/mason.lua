return {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    cond = require('toni.utils').is_workstation,
    config = function()
        require('mason').setup({
            ui = {
                icons = {
                    server_installed = '✓',
                    server_pending = '➜',
                    server_uninstalled = '✗',
                },
            },
        })
    end,
}
