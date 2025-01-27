local todo_keywords = { 'FIX', 'TODO', 'HACK', 'WARN', 'PERF', 'NOTE', 'TEST' }
local is_workstation = require('toni.utils').is_workstation

return {
    -------------------- EDITING --------------------
    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
    },
    {
        'johmsalas/text-case.nvim',
        keys = {
            {
                -- k for "kebab-case"
                'crk',
                function()
                    require('textcase').current_word('to_dash_case')
                end,
            },
            {
                'crc',
                function()
                    require('textcase').current_word('to_camel_case')
                end,
            },
            {
                'crl',
                function()
                    require('textcase').current_word('to_snake_case')
                end,
            },
            {
                'crp',
                function()
                    require('textcase').current_word('to_pascal_case')
                end,
            },
            {
                'cru',
                function()
                    require('textcase').current_word('to_constant_case')
                end,
            },
            -- this does not fully work yet
            {
                'crt',
                function()
                    require('textcase').current_word('to_title_case')
                end,
            },
        },
        opts = {
            default_keymappings_enabled = false,
        },
    },

    -------------------- NAVIGATION --------------------
    {
        'mrjones2014/smart-splits.nvim',
        -- TODO: works for now, but may be better with a check if the current terminal is kitty
        cond = is_workstation,
        -- TODO: use `keys`
        event = 'VeryLazy',
        build = './kitty/install-kittens.bash',
        config = function()
            local map = require('toni.utils').map
            map({ 'n', 'i', 'x', 't' }, { '<C-h>', '<C-Left>' }, require('smart-splits').move_cursor_left)
            map({ 'n', 'i', 'x', 't' }, { '<C-j>', '<C-Down>' }, require('smart-splits').move_cursor_down)
            map({ 'n', 'i', 'x', 't' }, { '<C-k>', '<C-Up>' }, require('smart-splits').move_cursor_up)
            -- Unsure where `C-l` is already mapped
            map(
                { 'n', 'i', 'x', 't' },
                { '<C-l>', '<C-Right>' },
                require('smart-splits').move_cursor_right,
                { unique = false }
            )
            map({ 'n', 'i', 'x', 't' }, { '<A-,>' }, require('smart-splits').resize_left)
            map({ 'n', 'i', 'x', 't' }, { '<A-]>' }, require('smart-splits').resize_down)
            map({ 'n', 'i', 'x', 't' }, { '<A-[>' }, require('smart-splits').resize_up)
            map({ 'n', 'i', 'x', 't' }, { '<A-.>' }, require('smart-splits').resize_right)
            -- map('n', { 'h', 'Left' }, require('smart-splits').swap_buf_left)
            -- map('n', { 'j', 'Down' }, require('smart-splits').swap_buf_down)
            -- map('n', { 'k', 'Up' }, require('smart-splits').swap_buf_up)
            -- map('n', { 'l', 'Right' }, require('smart-splits').swap_buf_right)
        end,
    },
    {
        'rgroli/other.nvim',
        keys = { 'gp', 'gP' },
        config = function()
            local map = require('toni.utils').map
            require('other-nvim').setup({
                mappings = {
                    'golang',
                    'react',
                },
            })
            map('n', 'gp', '<Nop>')
            map('n', 'gP', '<cmd>Other<CR>')
            local context_mappings = {
                c = 'component',
                i = 'implementation',
                h = 'html',
                s = 'scss',
                e = 'service',
                t = 'test',
                v = 'view',
            }
            for letter, context in pairs(context_mappings) do
                -- gp${lowerLetter} opens other in current window
                map('n', 'gp' .. letter, '<cmd>:Other ' .. context .. '<CR>')
                -- gp${upperLetter} opens other in vertical split
                map('n', 'gp' .. string.upper(letter), '<cmd>:OtherVSplit ' .. context .. '<CR>')
            end
        end,
    },

    -------------------- TEXT OBJECTS --------------------
    {
        'chaoren/vim-wordmotion',
        keys = {
            { '<leader>w', mode = { 'n', 'o', 'x' } },
            { '<leader>b', mode = { 'n', 'o', 'x' } },
            { '<leader>e', mode = { 'n', 'o', 'x' } },
            { '<leader>ge', mode = { 'n', 'o', 'x' } },
            { '<leader>aw', mode = { 'o', 'x' } },
            { '<leader>iw', mode = { 'o', 'x' } },
        },
        init = function()
            vim.g.wordmotion_prefix = '<leader>'
        end,
    },

    -------------------- MOVEMENTS --------------------
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@type Flash.Config
        opts = {
            modes = {
                search = {
                    enabled = false,
                },
                char = {
                    enabled = false,
                },
            },
        },
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
        },
    },

    -------------------- APPEARANCE --------------------
    {
        'karb94/neoscroll.nvim',
        cond = is_workstation,
        keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        config = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        main = 'ibl',
        opts = {
            scope = {
                show_start = false,
            },
        },
    },
    {
        'j-hui/fidget.nvim',
        cond = is_workstation,
        event = 'VeryLazy',
        config = true,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {
            input = {
                insert_only = false,
                start_in_insert = false,
            },
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'VeryLazy',
        config = function()
            require('colorizer').setup({
                opts = {
                    names = false,
                },
            })
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            {
                ']t',
                function()
                    require('todo-comments').jump_next({ keywords = todo_keywords })
                end,
            },
            {
                '[t',
                function()
                    require('todo-comments').jump_prev({ keywords = todo_keywords })
                end,
            },
        },
        opts = {
            highlight = {
                -- vim regex
                pattern = [[.*<(KEYWORDS)\s*:?]],
            },
            search = {
                -- ripgrep regex
                pattern = [[\b(KEYWORDS)\b]],
            },
        },
    },

    -------------------- MISC --------------------
    -- TODO use option `winfixbuf` for specific buffers
    {
        'stevearc/stickybuf.nvim',
        event = 'BufReadPre',
        opts = {},
    },
    {
        'Aasim-A/scrollEOF.nvim',
        event = { 'CursorMoved', 'WinScrolled' },
        opts = {},
    },
    {
        'chrishrb/gx.nvim',
        keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } },
        cmd = { 'Browse' },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        config = true, -- default settings
    },
}
