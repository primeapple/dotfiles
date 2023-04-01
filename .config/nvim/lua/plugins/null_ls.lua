return {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
    },
    config = function()
        local null_ls = require('null-ls')
        local on_attach = require('toni.utils').on_attach

        null_ls.setup({
            sources = {
                -- lua
                null_ls.builtins.formatting.stylua,
                -- fish
                null_ls.builtins.diagnostics.fish,
                null_ls.builtins.formatting.fish_indent,
                -- javascript
                null_ls.builtins.formatting.prettierd,
                -- rust
                -- TODO: is this done by rusttools?
                -- null_ls.builtins.formatting.rustfmt,
            },
            on_attach = on_attach,
        })
    end,
}
