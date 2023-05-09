-- TODO
-- - Make Copy work without marking
-- - Use visual mode to mark multiple files
return {
    {
        'tamago324/lir.nvim',
        enabled = false,
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'tamago324/lir-git-status.nvim',
        },
        config = function()
            local map = require('toni.utils').map
            map('n', '-', [[<Cmd>execute 'e ' .. expand('%:p:h')<CR>]])

            local actions = require('lir.actions')
            local clipboard_actions = require('lir.clipboard.actions')
            local mark_actions = require('lir.mark.actions')

            require('lir').setup({
                show_hidden_files = true,
                devicons = {
                    enable = true,
                },
                float = { winblend = 0 }, -- keep float setting even if you don't use it, otherwise it will crash
                hide_cursor = false,

                mappings = {
                    ['<CR>'] = actions.edit,
                    ['<C-->'] = actions.split,
                    ['<C-/>'] = actions.vsplit,
                    ['q'] = actions.quit,
                    ['-'] = actions.up,

                    ['M'] = actions.mkdir,
                    ['T'] = actions.touch,
                    ['R'] = actions.rename,
                    ['Y'] = actions.yank_path,
                    ['.'] = actions.toggle_show_hidden,
                    ['D'] = actions.delete,

                    ['C'] = clipboard_actions.copy,
                    ['X'] = clipboard_actions.cut,
                    ['P'] = clipboard_actions.paste,

                    ['m'] = mark_actions.toggle_mark,
                },
            })

            require('lir.git_status').setup()
        end,
    },
}
