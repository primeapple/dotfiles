return {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {
            enabled = true,
        },
        image = {
            enabled = true,
        },
        indent = {
            enabled = true,
        },
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
    keys = {
        {
            '<leader>G',
            function()
                Snacks.gitbrowse()
            end,
            desc = 'Git Browse',
            mode = { 'n', 'v' },
        },
    },
}
