return {
    {
        'monkoose/neocodeium',
        enabled = false,
        event = 'VeryLazy',
        config = function()
            local neocodeium = require('neocodeium')
            neocodeium.setup({
                manual = true,
            })

            -- close nvim cmp when ai completions are displayed
            vim.api.nvim_create_autocmd('User', {
                pattern = 'NeoCodeiumCompletionDisplayed',
                callback = function()
                    require('cmp').abort()
                end,
            })
            vim.keymap.set('i', '<A-Space>',  neocodeium.cycle_or_complete)
            vim.keymap.set('i', '<A-l>', neocodeium.accept)
            vim.keymap.set('i', '<A-f>', neocodeium.accept_word)
            vim.keymap.set('i', '<C-f>', neocodeium.accept_line)
        end,
    },
}
