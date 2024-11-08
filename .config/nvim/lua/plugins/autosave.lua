local api = vim.api
local fn = vim.fn

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
                trigger_events = {
                    -- defer_save = { 'InsertEnter' },
                    -- cancel_deferred_save = { 'InsertEnter' },
                    -- immediate_save = {
                    --     'FocusLost',
                    --     { 'BufLeave', pattern = { '*.lua' } },
                    -- },
                },
                debounce_delay = 3000,
                condition = function(buf)
                    -- don't save for special-buffers
                    if fn.getbufvar(buf, '&buftype') ~= '' then
                        return false
                    end
                    if vim.list_contains({ "" }, fn.getbufvar(buf, '&filetype')) then
                        return false
                    end
                    return true
                end,
                noautocmd = false,
                -- debug = true,
            })

            if require('toni.utils').is_workstation() then
                local group = api.nvim_create_augroup('autosave', {})
                -- udate tpipeline after save
                api.nvim_create_autocmd('User', {
                    pattern = 'AutoSaveWritePost',
                    group = group,
                    callback = function()
                        fn['tpipeline#update']()
                    end,
                })

                api.nvim_create_autocmd('User', {
                    pattern = 'AutoSaveEnable',
                    group = group,
                    callback = function()
                        vim.notify('AutoSave enabled', vim.log.levels.INFO)
                    end,
                })

                api.nvim_create_autocmd('User', {
                    pattern = 'AutoSaveDisable',
                    group = group,
                    callback = function()
                        vim.notify('AutoSave disabled', vim.log.levels.INFO)
                    end,
                })
            end
        end,
    },
}
