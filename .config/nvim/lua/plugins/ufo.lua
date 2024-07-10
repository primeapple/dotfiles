return {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = {
        'kevinhwang91/promise-async',
        {
            'luukvbaal/statuscol.nvim',
            config = function()
                local builtin = require('statuscol.builtin')
                require('statuscol').setup({
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
                        { text = { '%s' }, click = 'v:lua.ScSa' },
                        { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
                    },
                })
            end,
        },
    },
    keys = { 'zR', 'zM', '<leader><space>', 'zA' },
    init = function()
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function()
        local map = require('toni.utils').map
        local ufo = require('ufo')
        ufo.setup({
            close_fold_kinds_for_ft = {
                default = { 'imports', 'comment' },
            },
        })
        map('n', 'zR', ufo.openAllFolds)
        map('n', 'zM', ufo.closeAllFolds)
        map('n', '<leader><space>', 'za')
        map('n', 'K', function()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end)
    end,
}
