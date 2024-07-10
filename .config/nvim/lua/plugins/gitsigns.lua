return {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    config = function()
        require('gitsigns').setup({
            numhl = true,
            yadm = {
                enable = true,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local map = require('toni.utils').map
                -- Navigation
                map({ 'n', 'x' }, ']g', function()
                    if vim.wo.diff then
                        return ']g'
                    end
                    vim.schedule(function()
                        gs.next_hunk({ navigation_message = false })
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr })

                map({ 'n', 'x' }, '[g', function()
                    if vim.wo.diff then
                        return '[g'
                    end
                    vim.schedule(function()
                        gs.prev_hunk({ navigation_message = false })
                    end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr })

                -- suggested actions
                map('n', '<leader>ga', gs.stage_hunk, { buffer = bufnr })
                map('x', '<leader>ga', function()
                    gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { buffer = bufnr })
                map('n', '<leader>gA', gs.stage_buffer, { buffer = bufnr })
                map('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr })
                map('x', '<leader>gr', function()
                    gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { buffer = bufnr })
                map('n', '<leader>gR', gs.reset_buffer, { buffer = bufnr })
                map('n', '<leader>gu', gs.undo_stage_hunk, { buffer = bufnr })
                map('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr })
                map('n', '<leader>gb', function()
                    gs.blame_line({ full = true })
                end, { buffer = bufnr })
                map('n', '<leader>gB', gs.toggle_current_line_blame, { buffer = bufnr })
                map('n', '<leader>gd', gs.diffthis, { buffer = bufnr })
                map('n', '<leader>gD', function()
                    gs.diffthis('~')
                end, { buffer = bufnr })
            end,
        })
    end,
}
