return {
    {
        'David-Kunz/jester',
        dependencies = { 'akinsho/toggleterm.nvim' },
        ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue' },
        config = function()
            require('jester').setup({
                terminal_cmd = 'ToggleTerm',
                path_to_jest_run = './node_modules/.bin/jest',
                path_to_jest_debug = './node_modules/.bin/jest'
            })
            local map = require('toni.utils').map
            map('n', '<leader>rr', require('jester').run_last)
            map('n', '<leader>rf', require('jester').run_file)
            map('n', '<leader>rn', require('jester').run)
            map('n', '<leader>rR', require('jester').debug_last)
            map('n', '<leader>rF', require('jester').debug_file)
            map('n', '<leader>rN', require('jester').debug)
        end
    }
    -- TODO: checkout later, would prefer it over jester
    -- use { 'nvim-neotest/neotest' }
}
