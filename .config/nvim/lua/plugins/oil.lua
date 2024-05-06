return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'refractalize/oil-git-status.nvim',
        },
        config = function()
            local oil = require('oil')

            local copy_entry_relative_path = function()
                local entry = oil.get_cursor_entry()
                local dir = oil.get_current_dir()
                if not entry or not dir then
                    return
                end
                local filepath = dir .. entry.name
                local relpath = vim.fn.fnamemodify(filepath, ':.')
                vim.fn.setreg('+', relpath)
            end

            oil.setup({
                keymaps = {
                    ['<C-/>'] = 'actions.select_vsplit',
                    ['<C-->'] = 'actions.select_split',
                    ['<M-y>'] = 'actions.copy_entry_path',
                    ['<C-l>'] = false,
                    ['<C-h>'] = false,
                    ['<C-r>'] = 'actions.refresh',
                    ['<C-y>'] = copy_entry_relative_path,
                },
                win_options = {
                    signcolumn = "yes:2"
                }
            })
            local map = require('toni.utils').map
            map('n', '-', oil.open)

            require('oil-git-status').setup()
        end,
    },
}
