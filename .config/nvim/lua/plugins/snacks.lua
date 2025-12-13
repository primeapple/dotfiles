local with_pre_save = require('toni.utils').with_pre_save

return {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {
            enabled = true,
        },
        gitbrowse = {
            what = "file",
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
        picker = {
            enabled = true,
            list = {
                keys = {

                },
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
        {
            '<leader>S',
            function()
                Snacks.picker.resume()
            end,
            desc = 'Resume',
        },
        {
            '<leader>ss',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Smart Find Files',
        },
        {
            '<leader>sf',
            function()
                Snacks.picker.files()
            end,
            desc = 'Find Files',
        },
        {
            '<leader>sw',
            function()
                Snacks.picker.grep()
            end,
            desc = 'Grep',
        },
        {
            '<leader>sW',
            function()
                Snacks.picker.grep_word()
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        {
            '<leader>so',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Old files',
        },
        {
            '<leader>sk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'Keymaps',
        },
        {
            '<leader>sh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help Pages',
        },
        {
            '<leader>sg',
            with_pre_save(function()
                Snacks.picker.git_status()
            end),
            desc = 'Git Status',
        },
    },
}
