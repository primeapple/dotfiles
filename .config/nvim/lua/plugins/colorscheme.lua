return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        build = ':KanagawaCompile',
        config = function()
            require('kanagawa').setup({
                compile = true,
            })
            vim.api.nvim_command('colorscheme kanagawa')
        end
    }

}
