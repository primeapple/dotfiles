local is_kitty = require('toni.utils').is_kitty
local is_workstation = require('toni.utils').is_workstation

return {
    -------------------- EDITING --------------------
    {
        'andymass/vim-matchup',
        event = 'VeryLazy',
        ---@type matchup.Config
        opts = {
            matchparen = {
                offscreen = {
                    method = 'popup',
                },
            },
            treesitter = {
                stopline = 500,
            },
        },
    },
    {
        'johmsalas/text-case.nvim',
        keys = { 'ga', mode = { 'n', 'x' } },
        cmd = { 'Subs' },
        config = true,
    },

    -------------------- NAVIGATION --------------------
    {
        'mrjones2014/smart-splits.nvim',
        cond = is_kitty,
        keys = {
            {
                '<C-Left>',
                function()
                    require('smart-splits').move_cursor_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-h>',
                function()
                    require('smart-splits').move_cursor_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-Right>',
                function()
                    require('smart-splits').move_cursor_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-l>',
                function()
                    require('smart-splits').move_cursor_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-Up>',
                function()
                    require('smart-splits').move_cursor_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-k>',
                function()
                    require('smart-splits').move_cursor_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-Down>',
                function()
                    require('smart-splits').move_cursor_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-j>',
                function()
                    require('smart-splits').move_cursor_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-Left>',
                function()
                    require('smart-splits').resize_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-h>',
                function()
                    require('smart-splits').resize_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-Right>',
                function()
                    require('smart-splits').resize_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-l>',
                function()
                    require('smart-splits').resize_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-Up>',
                function()
                    require('smart-splits').resize_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-k>',
                function()
                    require('smart-splits').resize_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-Down>',
                function()
                    require('smart-splits').resize_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<A-j>',
                function()
                    require('smart-splits').resize_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-Left>',
                function()
                    require('smart-splits').swap_buf_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-h>',
                function()
                    require('smart-splits').swap_buf_left()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-Right>',
                function()
                    require('smart-splits').swap_buf_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-l>',
                function()
                    require('smart-splits').swap_buf_right()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-Up>',
                function()
                    require('smart-splits').swap_buf_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-k>',
                function()
                    require('smart-splits').swap_buf_up()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-Down>',
                function()
                    require('smart-splits').swap_buf_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
            {
                '<C-A-j>',
                function()
                    require('smart-splits').swap_buf_down()
                end,
                mode = { 'n', 'i', 'x', 't' },
            },
        },
        version = '>=1.0.0',
        event = 'VeryLazy',
        build = './kitty/install-kittens.bash',
        config = true,
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
    {
        'cbochs/grapple.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cmd = 'Grapple',
        keys = {
            {
                'gh',
                function()
                    if vim.v.count > 0 then
                        return '<cmd>Grapple select index=' .. vim.v.count .. '<CR>'
                    else
                        if vim.bo.filetype == 'oil' then
                            local Oil = require('oil')
                            local filename = Oil.get_cursor_entry().name
                            local directory = Oil.get_current_dir()

                            local Grapple = require('grapple')
                            local Path = require('grapple.path')
                            Grapple.toggle({ path = Path.join(directory, filename) })
                        else
                            return '<cmd>Grapple toggle<cr>'
                        end
                    end
                end,
                desc = 'Grapple toggle/move tag',
                expr = true,
            },
            { 'gH', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
            { ']h', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
            { '[h', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
        },
        opts = {
            scope = 'git_branch',
        },
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
        enabled = false,
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
        'mcauley-penney/visual-whitespace.nvim',
        keys = { 'v', '<C-v>', { 'V', 'vg_' }, { 'vv', 'V' } },
        config = true,
    },
    {
        'jake-stewart/auto-cmdheight.nvim',
        lazy = false,
        config = true,
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
