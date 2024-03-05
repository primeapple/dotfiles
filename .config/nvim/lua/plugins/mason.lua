return {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        'zapling/mason-conform.nvim',
        'rshkarin/mason-nvim-lint',
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
        require('mason-conform').setup()
        require('mason-nvim-lint').setup()
    end,
}
