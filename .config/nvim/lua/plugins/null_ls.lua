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
                null_ls.builtins.formatting.prettierd.with({
                    condition = function(utils)
                        return utils.root_has_file('prettier.config.js')
                    end,
                }),
                null_ls.builtins.formatting.rome.with({
                    condition = function(utils)
                        return utils.root_has_file('rome.json')
                    end,
                }),
                -- rust
                -- TODO: is this done by rusttools?
                -- null_ls.builtins.formatting.rustfmt,
            },
            on_attach = on_attach,
            root_dir = require('null-ls.utils').root_pattern('.null-ls-root', 'package.json', 'Makefile', '.git'),
        })
    end,
}
