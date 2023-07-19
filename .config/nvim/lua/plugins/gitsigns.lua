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

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']g', function()
                        if vim.wo.diff then
                            return ']g'
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    map('n', '[g', function()
                        if vim.wo.diff then
                            return '[g'
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true })

                    -- suggested actions
                    map({ 'n', 'v' }, '<leader>ga', ':Gitsigns stage_hunk<CR>')
                    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
                    map('n', '<leader>gS', gs.stage_buffer)
                    map('n', '<leader>gu', gs.undo_stage_hunk)
                    map('n', '<leader>gR', gs.reset_buffer)
                    map('n', '<leader>gp', gs.preview_hunk)
                    map('n', '<leader>gb', function()
                        gs.blame_line({ full = true })
                    end)
                    map('n', '<leader>gd', gs.diffthis)
                    map('n', '<leader>gD', function()
                        gs.diffthis('~')
                    end)
                    -- map('n', '<leader>td', gs.toggle_deleted)
                end,
            })
        end,
    },
}
