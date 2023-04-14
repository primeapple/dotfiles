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
        end,
    },
}
