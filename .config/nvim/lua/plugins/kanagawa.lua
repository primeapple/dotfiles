return {
    'rebelot/kanagawa.nvim',
    event = 'UIEnter',
    build = ':KanagawaCompile',
    config = function()
        require('kanagawa').setup({
            compile = true,
            dimInactive = true,
            overrides = function(colors)
                local theme = colors.theme
                return {
                    MsgArea = { fg = theme.ui.fg_dim },
                    StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim },

                    -- this is originally set to `CONSTANT`, which totally kills JavaScript development
                    -- since most JS these days is functional and EVERYTHING is a constant
                    -- a better way would be to set `@lsp.typemod.variable/function` explicitely for JS
                    -- but there are so much custom filetypes (svelte, typescript, jsx, vue, ...)
                    ['@lsp.mod.readonly'] = {},
                    -- ['@lsp.typemod.variable'] = { link = '@variable' },
                    -- ['@lsp.typemod.function'] = { link = '@function' },
                }
            end,
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none',
                        },
                    },
                },
            },
        })
        vim.api.nvim_command('colorscheme kanagawa')
    end,
}
