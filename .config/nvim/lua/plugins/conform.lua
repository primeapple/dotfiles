return {
    'stevearc/conform.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                css = { { 'prettierd', 'prettier' } },
                fish = { 'fish_indent' },
                html = { { 'prettierd', 'prettier' } },
                javascript = { { 'prettierd', 'prettier' } },
                javascriptreact = { { 'biome', 'prettierd', 'prettier' } },
                json = { { 'biome', 'prettierd', 'prettier' } },
                lua = { 'stylua' },
                markdown = { { 'prettierd', 'prettier' } },
                python = { 'ruff_format' },
                rust = { 'rustfmt' },
                sql = { 'sql_formatter' },
                sh = { 'shellcheck' },
                svelte = { { 'prettierd', 'prettier' } },
                typescript = { { 'biome', 'prettierd', 'prettier' } },
                typescriptreact = { { 'biome', 'prettierd', 'prettier' } },
                yaml = { { 'prettierd', 'prettier', 'yamlfmt' } },
            },
        })

        require('toni.utils').map({ 'n', 'v' }, '<leader>af', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end)
    end,
}
