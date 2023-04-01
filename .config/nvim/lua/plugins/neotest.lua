return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'haydenmeade/neotest-jest',
        },
        keys = {
            {
                '<leader>rn',
                function()
                    require('neotest').run.run()
                end,
            },
            {
                '<leader>rf',
                function()
                    require('neotest').run.run(vim.fn.expand('%'))
                end,
            },
            {
                '<leader>rr',
                function()
                    require('neotest').run.run_last()
                end,
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
                '[t',
                function()
                    require('neotest').jump.prev({ status = 'failed' })
                end,
            },
            {
                ']t',
                function()
                    require('neotest').jump.next({ status = 'failed' })
                end,
            },
            {
                '<leader>R',
                function()
                    require('neotest').stop()
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
                    -- require("neotest-vim-test")({
                    --     ignore_file_types = { "python", "vim", "lua" },
                    -- }),
                },
                quickfix = {
                    enabled = false,
                    open = false,
                },
                output_panel = {
                    open = 'rightbelow vsplit | resize 30',
                },
                status = {
                    virtual_text = false,
                    signs = true,
                },
            })
        end,
    },
}
