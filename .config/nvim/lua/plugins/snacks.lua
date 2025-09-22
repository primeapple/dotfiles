return {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
        input = {
            enabled = true,
            win = {
                on_win = function()
                    vim.schedule(function()
                        vim.cmd('stopinsert')
                    end)
                end,
            },
        },
    },
}
