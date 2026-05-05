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
            what = 'file',
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
                keys = {},
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
            '<leader>F',
            function()
                Snacks.picker.resume()
            end,
            desc = 'Resume',
        },
        {
            '<leader>fs',
            function()
                Snacks.picker.smart()
            end,
            desc = 'Smart Find Files',
        },
        {
            '<leader>ff',
            function()
                Snacks.picker.files({ hidden = true })
            end,
            desc = 'Find Files',
        },
        {
            '<leader>fw',
            function()
                Snacks.picker.grep({ hidden = true })
            end,
            desc = 'Grep',
        },
        {
            '<leader>fW',
            function()
                Snacks.picker.grep_word({ hidden = true })
            end,
            desc = 'Visual selection or word',
            mode = { 'n', 'x' },
        },
        {
            '<leader>fo',
            function()
                Snacks.picker.recent()
            end,
            desc = 'Old files',
        },
        {
            'gd',
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = 'Goto Definition',
        },
        {
            'grr',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'References',
        },
        {
            'grt',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto Type Definition',
        },
        {
            'grs',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = 'LSP Symbols',
        },
        {
            'grw',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = 'LSP Workspace Symbols',
        },
        {
            '<leader>fm',
            function()
                Snacks.picker.keymaps()
            end,
            desc = 'Keymaps',
        },
        {
            '<leader>fh',
            function()
                Snacks.picker.help()
            end,
            desc = 'Help Pages',
        },
        {
            '<leader>fg',
            with_pre_save(function()
                Snacks.picker.git_status()
            end),
            desc = 'Git Status',
        },
        {
            '<leader>z',
            function()
                Snacks.zen.zoom()
            end,
            desc = 'Toggle Zen Mode',
        },
    },
}
