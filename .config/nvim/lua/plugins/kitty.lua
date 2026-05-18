local is_kitty = require('toni.utils').is_kitty

return {
    {
        'mikesmithgh/kitty-scrollback.nvim',
        cond = is_kitty,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
        event = { 'User KittyScrollbackLaunch' },
        version = '*', -- latest stable version, may have breaking changes if major version changed
        config = true
    },
    {
        'mrjones2014/smart-splits.nvim',
        lazy = false,
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
        build = './kitty/install-kittens.bash',
        config = true,
    }
}
