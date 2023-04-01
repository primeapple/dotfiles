return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    dependencies = {
        'jay-babu/mason-null-ls.nvim',
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
            automatic_installation = true,
        })

        require('mason-null-ls').setup({
            automatic_installation = true,
        })
    end,
}
