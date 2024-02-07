return {
    -------------------- EDITING --------------------
    {
        'tpope/vim-unimpaired',
        keys = { '[', ']', 'yo' },
    },
    {
        -- TODO replaced by mini
        'numToStr/Comment.nvim',
        enable = false,
        keys = {
            { 'gc', mode = { 'n', 'v' } },
            { 'gb', mode = { 'n', 'v' } },
        },
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        init = function()
            vim.g.matchup_matchparen_offscreen = { method = 'popup' }
        end,
    },
    {
        -- TODO replace with mini
        'windwp/nvim-autopairs',
        event = 'VeryLazy',
        opts = {
            disable_in_macro = true,
        },
    },

    -------------------- NAVIGATION --------------------
    {
        'mrjones2014/smart-splits.nvim',
        -- TODO use `keys`
        event = 'VeryLazy',
        build = './kitty/install-kittens.bash',
        config = function()
            local map = require('toni.utils').map
            map({ 'n', 'i', 'v', 't' }, { '<C-h>', '<C-Left>' }, require('smart-splits').move_cursor_left)
            map({ 'n', 'i', 'v', 't' }, { '<C-j>', '<C-Down>' }, require('smart-splits').move_cursor_down)
            map({ 'n', 'i', 'v', 't' }, { '<C-k>', '<C-Up>' }, require('smart-splits').move_cursor_up)
            map({ 'n', 'i', 'v', 't' }, { '<C-l>', '<C-Right>' }, require('smart-splits').move_cursor_right)
            -- TODO maybe use <leader>s hjkl/HJKL
            -- map({ 'n', 'i', 'v', 't' }, { '<A-Left>' }, require('smart-splits').resize_left)
            -- map({ 'n', 'i', 'v', 't' }, { '<A-Down>' }, require('smart-splits').resize_down)
            -- map({ 'n', 'i', 'v', 't' }, { '<A-Up>' }, require('smart-splits').resize_up)
            -- map({ 'n', 'i', 'v', 't' }, { '<A-Right>' }, require('smart-splits').resize_right)
            -- map('n', { 'h', 'Left' }, require('smart-splits').swap_buf_left)
            -- map('n', { 'j', 'Down' }, require('smart-splits').swap_buf_down)
            -- map('n', { 'k', 'Up' }, require('smart-splits').swap_buf_up)
            -- map('n', { 'l', 'Right' }, require('smart-splits').swap_buf_right)
        end
    },

    -------------------- TEXT OBJECTS --------------------
    {
        'chaoren/vim-wordmotion',
        keys = {
            { '<leader>w',  mode = { 'n', 'o', 'x' } },
            { '<leader>b',  mode = { 'n', 'o', 'x' } },
            { '<leader>e',  mode = { 'n', 'o', 'x' } },
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
            { 'gG', mode = { 'o', 'v' } },
            { 'ii', mode = { 'o', 'v' } },
            { 'ik', mode = { 'o', 'v' } },
            { 'iv', mode = { 'o', 'v' } },
            { 'R',  mode = { 'o', 'v' } },
        },
        opts = {
            useDefaultKeymaps = true,
        },
    },

    -------------------- MOVEMENTS --------------------
    {
        'ggandor/leap.nvim',
        keys = {
            { 's',  '<Plug>(leap-forward-to)',   mode = { 'n', 'o', 'v' } },
            { 'S',  '<Plug>(leap-backward-to)',  mode = { 'n', 'o', 'v' } },
            { 'gs', '<Plug>(leap-cross-window)', mode = { 'n', 'o', 'v' } },
        },
    },
    {
        'bronson/vim-visual-star-search',
        keys = { { '*', mode = 'v' } },
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
        enable = false,
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
        tag = 'legacy',
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

    -------------------- Languages/Tools --------------------
    {
        'lervag/vimtex',
        ft = 'tex',
    },

    -------------------- MISC --------------------
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        ft = { 'markdown' },
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        keys = { '<C-t>', '<leader>r' },
        opts = {
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.3
                end
            end,
            open_mapping = '<C-t>',
            direction = 'vertical',
        },
    },
    {
        'ja-ford/delaytrain.nvim',
        event = 'VeryLazy',
        opts = {
            grace_period = 5,
        },
    },
    {
        'stevearc/stickybuf.nvim',
        event = 'BufReadPre',
        opts = {},
    },
}
