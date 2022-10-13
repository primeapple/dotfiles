local telescope = require('telescope')

telescope.setup({
    defaults = {
        path_display = { shorten = { len = 3, exclude = {1, -2, -1} } },
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
            }
        }
    }
})

telescope.load_extension('zf-native')
-- telescope.load_extension('dap')

local map = require('toni.utils').map

-- basic mappings
map('n', '<leader>F', '<cmd> :Telescope resume <CR>')
map('n', '<leader>fb', '<cmd> :Telescope buffers <CR>')
map('n', '<leader>ff', '<cmd> :Telescope find_files <CR>')
map('n', '<leader>fa', '<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>')
map('n', '<leader>fh', '<cmd> :Telescope help_tags <CR>')
map('n', '<leader>fw', '<cmd> :Telescope live_grep <CR>')
map('n', '<leader>fW', '<cmd> :Telescope grep_string <CR>')
map('n', '<leader>fo', function() require('telescope.builtin').oldfiles({only_cwd=true}) end)
map('n', '<leader>fq', '<cmd> :Telescope quickfix <CR>')
map('n', '<leader>fQ', '<cmd> :Telescope quickfixhistory <CR>')

-- git mappings
-- map('n', '<leader>fc', '<cmd> :Telescope git_commits <CR>')
map('n', '<leader>fg', '<cmd> :Telescope git_status <CR>')

-- dap mappings
map('n', '<leader>fd', '<cmd> :Telescope dap <CR>')
-- there is also:
-- :Telescope dap commands
-- :Telescope dap configurations
-- :Telescope dap list_breakpoints
-- :Telescope dap variables
-- :Telescope dap frames

