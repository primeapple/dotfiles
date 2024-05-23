return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        config = function()
            local map = require('toni.utils').map

            require('mini.ai').setup({
                custom_textobjects = {
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line('$'),
                            col = math.max(vim.fn.getline('$'):len(), 1),
                        }
                        return { from = from, to = to }
                    end,
                },
            })
            require('mini.bracketed').setup({
                treesitter = { suffix = 'n', options = {} },
            })
            -- Redo with U
            map('n', 'U', '<C-R><Cmd>lua MiniBracketed.register_undo_state()<CR>')

            require('mini.comment').setup()
            require('mini.cursorword').setup()
            require('mini.move').setup({
                mappings = {
                    up = '[e',
                    down = ']e',
                    left = '<<',
                    right = '>>',
                    line_up = '[e',
                    line_down = ']e',
                    line_left = '<<',
                    line_right = '>>',
                },
            })
            require('mini.pairs').setup()
            require('mini.surround').setup({
                mappings = {
                    add = 'gsa',
                    delete = 'gsd',
                    replace = 'gsc',
                    highlight = 'gsh',
                    find = 'gsf',
                    find_left = 'gsF',
                    update_n_lines = 'gsn',
                },
            })
        end,
    },
}
