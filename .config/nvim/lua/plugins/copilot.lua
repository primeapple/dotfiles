return {
    {
        'zbirenbaum/copilot.lua',
        enabled = false,
        event = 'VeryLazy',
        opts = {
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = '<M-l>',
                    accept_word = '<M-f>',
                    accept_line = '<C-f>',
                },
            },
            filetypes = {
                -- disable for files without filetype
                [''] = false,
                text = false,
                norg = false,
                -- because we don't want Copilot in `.env` files
                -- see https://github.com/zbirenbaum/copilot.lua/issues/111
                sh = function()
                    if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '%.env$') then
                        -- disable for .env files
                        return false
                    end
                    return true
                end,
            },
        },
    },
}
