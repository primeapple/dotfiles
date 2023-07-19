return {
    {
        'okuuva/auto-save.nvim',
        -- dev = true,
        event = 'VeryLazy',
        keys = {
            {
                '[oa',
                function()
                    require('auto-save').on()
                end,
            },
            {
                ']oa',
                function()
                    require('auto-save').off()
                end,
            },
            {
                'yoa',
                function()
                    require('auto-save').toggle()
                end,
            },
        },
        config = function()
            require('auto-save').setup({
                enabled = true,
                execution_message = {
                    dim = 0.2,
                },
                debounce_delay = 3000,
                condition = function(buf)
                    local fn = vim.fn
                    local utils = require('auto-save.utils.data')

                    -- don't save for special-buffers
                    if fn.getbufvar(buf, '&buftype') ~= '' then
                        return false
                    end
                    if utils.not_in(fn.getbufvar(buf, '&filetype'), { '' }) then
                        return true
                    end
                    return false
                end,
                noautocmd = false,
                debug = false,
            })
        end,
    },
}
