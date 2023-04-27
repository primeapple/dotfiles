return {
    {
        'okuuva/auto-save.nvim',
        -- dev = true,
        event = 'VeryLazy',
        opts = {
            debounce_delay = 1000,
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
            debug = false,
        },
    },
}
