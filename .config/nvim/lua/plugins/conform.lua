return {
    'stevearc/conform.nvim',
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
                rust = { 'rustfmt' },
                sql = { 'sql_formatter' },
                svelte = { { 'prettierd', 'prettier' } },
                typescript = { { 'biome', 'prettierd', 'prettier' } },
                typescriptreact = { { 'biome', 'prettierd', 'prettier' } },
                yaml = { { 'prettierd', 'prettier' } },
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
