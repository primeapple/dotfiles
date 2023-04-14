return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        build = ':KanagawaCompile',
        config = function()
            require('kanagawa').setup({
                compile = true,
                overrides = function(colors)
                    return {
                        ['@lsp.typemod.variable.local'] = { link = '@variable' },
                    }
                end,
            })
            vim.api.nvim_command('colorscheme kanagawa')
            -- TODO: Remove this when kanagawa.nvim is fixed
            -- for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
            --     vim.api.nvim_set_hl(0, group, {})
            -- end
        end,
    },
}
