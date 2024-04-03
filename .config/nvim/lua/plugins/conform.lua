return {
    'stevearc/conform.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')

        local js_formatter = function(bufnr)
            if conform.get_formatter_info('prettierd', bufnr).available then
                return { 'prettierd' }
            elseif  conform.get_formatter_info('prettier', bufnr).available then
                return { 'prettier' }
            else
                return { 'biome' }
            end
        end

        conform.setup({
            formatters_by_ft = {
                css = { { 'prettierd', 'prettier' } },
                fish = { 'fish_indent' },
                html = { { 'prettierd', 'prettier' } },
                javascript = js_formatter,
                javascriptreact = js_formatter,
                json = js_formatter,
                lua = { 'stylua' },
                markdown = { { 'prettierd', 'prettier' } },
                python = { 'ruff_format' },
                rust = { 'rustfmt' },
                sql = { 'sql_formatter' },
                sh = { 'shellcheck' },
                svelte = js_formatter,
                typescript = js_formatter,
                typescriptreact = js_formatter,
                yaml = { { 'prettierd', 'prettier', 'yamlfmt' } },
            },
            notify_on_error = false,
        })

        require('toni.utils').map({ 'n', 'x' }, '<leader>af', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end)
    end,
}
