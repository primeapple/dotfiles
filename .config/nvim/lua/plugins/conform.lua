return {
    'stevearc/conform.nvim',
    cond = require('toni.utils').is_workstation,
    dependencies = {
        'williamboman/mason.nvim',
    },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            'grf',
            function()
                require('conform').format({ async = true, lsp_format = 'fallback' })
            end,
            mode = { 'n', 'x' },
            desc = 'Format buffer',
        },
    },
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters = {
                djlint_gohtml = {
                    inherit = 'djlint',
                    append_args = { '--profile', 'golang', '--preserve-blank-lines' },
                },
            },
            formatters_by_ft = {
                css = { 'prettierd', 'prettier', stop_after_first = true },
                fish = { 'fish_indent' },
                gohtml = { 'djlint_gohtml' },
                html = { 'prettierd', 'prettier', stop_after_first = true },
                javascript = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                javascriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                json = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                lua = { 'stylua' },
                markdown = { 'prettierd', 'prettier', stop_after_first = true },
                python = { 'ruff_format' },
                rust = { 'rustfmt' },
                sql = { 'sql_formatter' },
                sh = { 'shellcheck' },
                svelte = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                typescript = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                typescriptreact = { 'prettierd', 'prettier', 'biome', stop_after_first = true },
                yaml = { 'prettierd', 'prettier', 'yamlfmt', stop_after_first = true },
                ['_'] = { 'trim_whitespace' },
            },
            notify_on_error = false,
        })
    end,
}
