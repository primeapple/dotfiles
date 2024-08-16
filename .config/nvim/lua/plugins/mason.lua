return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    cond = require('toni.utils').is_workstation,
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
    },
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

        require('mason-lspconfig').setup({
            ensure_installed = {
                'jdtls',
            },
        })
    end,
}
