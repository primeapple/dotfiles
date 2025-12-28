return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        event = 'VeryLazy',
        dependencies = { 'rafamadriz/friendly-snippets' },
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
                -- Per default this is `c`, but that's needed for next diff
                comment = { suffix = '', options = {} },
                treesitter = { suffix = 'n', options = {} },
            })
            -- Redo with U
            map('n', 'U', '<C-R><Cmd>lua MiniBracketed.register_undo_state()<CR>')

            require('mini.comment').setup()

            require('mini.cursorword').setup()

            require('mini.hipatterns').setup({
                highlighters = {
                    fixme = { pattern = '%s+%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                    hack = { pattern = '%s+%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
                    warn = { pattern = '%s+%f[%w]()WARN()%f[%W]', group = 'MiniHipatternsHack' },
                    todo = { pattern = '%s+%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
                    test = { pattern = '%s+%f[%w]()TEST()%f[%W]', group = 'MiniHipatternsTodo' },
                    note = { pattern = '%s+%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
                },
            })

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

            local snippets = require('mini.snippets')
            require('mini.snippets').setup({
                mappings = {
                    expand = '<A-Space>',
                    jump_next = '',
                    jump_prev = '',
                },
                snippets = {
                    snippets.gen_loader.from_file('~/.config/nvim/snippets/global.json'),
                    snippets.gen_loader.from_lang(),
                },
            })

            local jump_next = function()
                local is_active = MiniSnippets.session.get() ~= nil
                if is_active then
                    MiniSnippets.session.jump('next')
                    return ''
                end
                return '\t'
            end
            local jump_prev = function()
                local is_active = MiniSnippets.session.get() ~= nil
                if is_active then
                    MiniSnippets.session.jump('prev')
                    return ''
                end
                return '<BS>'
            end
            vim.keymap.set('i', '<Tab>', jump_next, { expr = true })
            vim.keymap.set('i', '<S-Tab>', jump_prev, { expr = true })

            -- Exit when going into normal mode
            local make_stop = function()
                local au_opts = { pattern = '*:n', once = true }
                au_opts.callback = function()
                    while MiniSnippets.session.get() do
                        MiniSnippets.session.stop()
                    end
                end
                vim.api.nvim_create_autocmd('ModeChanged', au_opts)
            end
            vim.api.nvim_create_autocmd('User', { pattern = 'MiniSnippetsSessionStart', callback = make_stop })

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
