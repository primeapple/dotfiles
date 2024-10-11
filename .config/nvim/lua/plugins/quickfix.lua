return {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    config = function()
        require('quicker').setup({
            opts = {
                number = true,
            },
            keys = {
                {
                    '>',
                    function()
                        require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = 'Expand quickfix context',
                },
                {
                    '<',
                    function()
                        require('quicker').collapse()
                    end,
                    desc = 'Collapse quickfix context',
                },
            },
        })
        local map = require('toni.utils').map
        map('n', 'ZC', function()
            require('quicker').toggle()
        end, {
            desc = 'Toggle quickfix',
        })
        map('n', 'ZL', function()
            require('quicker').toggle({ loclist = true })
        end, {
            desc = 'Toggle loclist',
        })
    end,
}
