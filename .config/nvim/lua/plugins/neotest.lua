local with_pre_save = require('toni.utils').with_pre_save

return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-neotest/nvim-nio',
            'nvim-lua/plenary.nvim',
            'nvim-neotest/neotest-jest',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'marilari88/neotest-vitest',
            'mfussenegger/nvim-dap',
        },
        cond = require('toni.utils').is_workstation,
        keys = {
            {
                '<leader>rn',
                with_pre_save(function()
                    require('neotest').run.run()
                end),
            },
            {
                '<leader>rf',
                with_pre_save(function()
                    require('neotest').run.run(vim.fn.expand('%'))
                end),
            },
            {
                '<leader>rr',
                with_pre_save(function()
                    require('neotest').run.run_last()
                end),
            },
            {
                '<leader>rd',
                with_pre_save(function()
                    require('neotest').run.run_last({ strategy = 'dap' })
                end),
            },
            {
                '<leader>rp',
                function()
                    require('neotest').output_panel.toggle()
                end,
            },
            {
                '<leader>rs',
                function()
                    require('neotest').summary.toggle()
                end,
            },
            {
                '<leader>ro',
                function()
                    require('neotest').output.open({ enter = true })
                end,
            },
            {
                '[r',
                function()
                    require('neotest').jump.prev({ status = 'failed' })
                end,
            },
            {
                ']r',
                function()
                    require('neotest').jump.next({ status = 'failed' })
                end,
            },
            {
                '<leader>R',
                function()
                    require('neotest').run.stop()
                end,
            },
        },
        config = function()
            require('neotest').setup({
                adapters = {
                    require('neotest-jest')({
                        jestConfigFile = 'jest.config.js',
                        env = { CI = true },
                    }),
                    require('neotest-vitest'),
                    -- require('neotest-vim-test')({
                    --     ignore_file_types = { 'python', 'vim', 'lua' },
                    -- }),
                },
                quickfix = {
                    enabled = false,
                    open = false,
                },
                output_panel = {
                    enabled = true,
                    open = 'rightbelow vsplit | resize 30',
                },
                status = {
                    enabled = true,
                    virtual_text = false,
                    signs = true,
                },
            })
        end,
    },
}
