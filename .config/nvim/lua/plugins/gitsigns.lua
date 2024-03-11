return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                    change = {
                        hl = 'GitSignsChange',
                        text = '~',
                        numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn',
                    },
                    delete = {
                        hl = 'GitSignsDelete',
                        text = '_',
                        numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn',
                    },
                    topdelete = {
                        hl = 'GitSignsDelete',
                        text = '‾',
                        numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn',
                    },
                    changedelete = {
                        hl = 'GitSignsChange',
                        text = '~',
                        numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn',
                    },
                },
                numhl = true,
                yadm = {
                    enable = true,
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local map = require('toni.utils').map
                    -- Navigation
                    map({ 'n', 'v' }, ']g', function()
                        if vim.wo.diff then
                            return ']g'
                        end
                        vim.schedule(function()
                            gs.next_hunk({ navigation_message = false })
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    map({ 'n', 'v' }, '[g', function()
                        if vim.wo.diff then
                            return '[g'
                        end
                        vim.schedule(function()
                            gs.prev_hunk({navigation_message = false})
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- suggested actions
                    map('n', '<leader>ga', gs.stage_hunk)
                    map('v', '<leader>ga', function()
                        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)
                    map('n', '<leader>gA', gs.stage_buffer)
                    map('n', '<leader>gr', gs.reset_hunk)
                    map('v', '<leader>gr', function()
                        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)
                    map('n', '<leader>gR', gs.reset_buffer)
                    map('n', '<leader>gu', gs.undo_stage_hunk)
                    map('n', '<leader>gp', gs.preview_hunk)
                    map('n', '<leader>gb', function()
                        gs.blame_line({ full = true })
                    end)
                    map('n', '<leader>gB', gs.toggle_current_line_blame)
                    map('n', '<leader>gd', gs.diffthis)
                    map('n', '<leader>gD', function()
                        gs.diffthis('~')
                    end)
                end,
            })
        end,
    },
}
