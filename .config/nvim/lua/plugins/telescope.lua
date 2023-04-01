return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        cmd = 'Telescope',
        keys = {
            -- basic mappings
            { '<leader>F', '<cmd>Telescope resume <CR>' },
            { '<leader>fb', '<cmd>Telescope buffers <CR>' },
            { '<leader>ff', '<cmd>Telescope find_files <CR>' },
            { '<leader>fa', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>' },
            { '<leader>fh', '<cmd>Telescope help_tags <CR>' },
            { '<leader>fw', '<cmd>Telescope live_grep <CR>' },
            { '<leader>fW', '<cmd>Telescope grep_string <CR>' },
            {
                '<leader>fo',
                function()
                    require('telescope.builtin').oldfiles({ only_cwd = true })
                end,
            },
            { '<leader>fq', '<cmd>Telescope quickfix <CR>' },
            { '<leader>fQ', '<cmd>Telescope quickfixhistory <CR>' },

            -- git mappings
            -- { '<leader>fc', '<cmd>Telescope git_commits <CR>' },
            { '<leader>fg', '<cmd>Telescope git_status <CR>' },

            -- dap mappings
            { '<leader>fd', '<cmd>Telescope dap <CR>' },
            -- there is also:
            -- :Telescope dap commands
            -- :Telescope dap configurations
            -- :Telescope dap list_breakpoints
            -- :Telescope dap variables
            -- :Telescope dap frames
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'natecraddock/telescope-zf-native.nvim',
            'nvim-telescope/telescope-dap.nvim',
        },
        config = function()
            local telescope = require('telescope')

            telescope.setup({
                defaults = {
                    path_display = { shorten = { len = 3, exclude = { 1, -2, -1 } } },
                    mappings = {
                        i = {
                            ['<C-d>'] = 'results_scrolling_down',
                            ['<C-u>'] = 'results_scrolling_up',
                            ['<C-f>'] = 'preview_scrolling_down',
                            ['<C-b>'] = 'preview_scrolling_up',
                            ['<C-->'] = 'select_horizontal',
                            ['<C-/>'] = 'select_vertical',
                        },
                        n = {
                            ['<C-d>'] = 'results_scrolling_down',
                            ['<C-u>'] = 'results_scrolling_up',
                            ['<C-f>'] = 'preview_scrolling_down',
                            ['<C-b>'] = 'preview_scrolling_up',
                            ['<C-->'] = 'select_horizontal',
                            ['<C-/>'] = 'select_vertical',
                        },
                    },
                },
            })

            telescope.load_extension('zf-native')
            telescope.load_extension('dap')
        end,
    },
}
