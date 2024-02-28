return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    dependencies = {
        'jay-babu/mason-nvim-dap.nvim',
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
            automatic_installation = true,
        })
    end,
}
