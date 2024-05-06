local todo_keywords = { 'FIX', 'TODO', 'HACK', 'WARN', 'PERF', 'NOTE', 'TEST' }

return {
    -------------------- EDITING --------------------
    {
        'tpope/vim-unimpaired',
        keys = { '[', ']', 'yo' },
    },
    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
    },
    {
        -- TODO: replace with mini
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {
            disable_in_macro = true,
        },
    },

    -------------------- NAVIGATION --------------------
    {
        'mrjones2014/smart-splits.nvim',
        -- TODO: use `keys`
        event = 'VeryLazy',
        build = './kitty/install-kittens.bash',
        config = function()
            local map = require('toni.utils').map
            map({ 'n', 'i', 'x', 't' }, { '<C-h>', '<C-Left>' }, require('smart-splits').move_cursor_left)
            map({ 'n', 'i', 'x', 't' }, { '<C-j>', '<C-Down>' }, require('smart-splits').move_cursor_down)
            map({ 'n', 'i', 'x', 't' }, { '<C-k>', '<C-Up>' }, require('smart-splits').move_cursor_up)
            -- Unsure where `C-l` is already mapped
            map({ 'n', 'i', 'x', 't' }, { '<C-l>', '<C-Right>' }, require('smart-splits').move_cursor_right, {unique=false})
            -- TODO: maybe use <leader>s hjkl/HJKL
            -- map({ 'n', 'i', 'x', 't' }, { '<A-Left>' }, require('smart-splits').resize_left)
            -- map({ 'n', 'i', 'x', 't' }, { '<A-Down>' }, require('smart-splits').resize_down)
            -- map({ 'n', 'i', 'x', 't' }, { '<A-Up>' }, require('smart-splits').resize_up)
            -- map({ 'n', 'i', 'x', 't' }, { '<A-Right>' }, require('smart-splits').resize_right)
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
                    'angular',
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
    {
        'chrisgrieser/nvim-various-textobjs',
        keys = {
            { 'gG', mode = { 'o', 'x' } },
            { 'ii', mode = { 'o', 'x' } },
            { 'ik', mode = { 'o', 'x' } },
            { 'iv', mode = { 'o', 'x' } },
            { 'R', mode = { 'o', 'x' } },
        },
        opts = {
            useDefaultKeymaps = true,
        },
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
    {
        'bronson/vim-visual-star-search',
        keys = { { '*', mode = 'x' } },
    },

    -------------------- APPEARANCE --------------------
    {
        'karb94/neoscroll.nvim',
        keys = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        config = true,
    },
    {
        'gbprod/stay-in-place.nvim',
        keys = { '=', '<', '>' },
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
        'NvChad/nvim-colorizer.lua',
        event = 'VeryLazy',
        opts = {
            user_default_options = {
                names = false,
                tailwind = 'lsp',
                mode = 'virtualtext',
                sass = {
                    enable = true,
                },
            },
        },
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
                pattern = [[.* <(KEYWORDS)\s*]],
            },
            search = {
                pattern = [[ \b(KEYWORDS)\b]],
            },
        },
    },
    {
        'Bekaboo/deadcolumn.nvim',
        event = 'VeryLazy',
    },

    -------------------- MISC --------------------
    -- TODO use option `winfixbuf` when upgrading to v0.10 and remove this plugin
    {
        'stevearc/stickybuf.nvim',
        event = 'BufReadPre',
        opts = {},
    },
}
