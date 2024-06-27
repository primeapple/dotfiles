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

            -- TODO remove with nvim 0.10
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
            require('mini.pairs').setup({
                -- see https://github.com/echasnovski/mini.nvim/issues/835
                mappings = {
                    -- Prevents the action if the cursor is just before any character or next to a "\".
                    ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][%s%)%]%}]' },
                    ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][%s%)%]%}]' },
                    ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][%s%)%]%}]' },
                    -- Prevents the action if the cursor is just before or next to any character.
                    ['"'] = {
                        action = 'closeopen',
                        pair = '""',
                        neigh_pattern = '[^%w][^%w]',
                        register = { cr = false },
                    },
                    ["'"] = {
                        action = 'closeopen',
                        pair = "''",
                        neigh_pattern = '[^%w][^%w]',
                        register = { cr = false },
                    },
                    ['`'] = {
                        action = 'closeopen',
                        pair = '``',
                        neigh_pattern = '[^%w][^%w]',
                        register = { cr = false },
                    },
                },
            })
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
