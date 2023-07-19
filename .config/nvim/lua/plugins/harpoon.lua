return {
    {
        'ThePrimeagen/harpoon',
        dependencies = 'nvim-lua/plenary.nvim',
        keys = {
            'gh',
            'gH',
            ']h',
            '[h',
        },
        config = function()
            require('harpoon').setup({
                global_settings = {
                    mark_branch = true,
                },
            })

            local map = require('toni.utils').map
            local function toggle_move()
                if vim.v.count > 0 then
                    -- this does not work (yet?)
                    -- require('harpoon.ui').nav_file(vim.v.count)
                    return '<cmd>lua require("harpoon.ui").nav_file(vim.v.count)<CR>'
                else
                    require('harpoon.mark').toggle_file()
                end
            end
            local function toggle_move_or_quick_menu()
                if vim.v.count > 0 then
                    return '<cmd>vsplit | lua require("harpoon.ui").nav_file(vim.v.count)<CR>'
                else
                    require('harpoon.ui').toggle_quick_menu()
                end
            end
            map('n', 'gh', toggle_move, { expr = true })
            map('n', ']h', require('harpoon.ui').nav_next)
            map('n', '[h', require('harpoon.ui').nav_prev)
            map('n', 'gH', require('harpoon.ui').toggle_quick_menu)
        end,
    },
}
