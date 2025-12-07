local api = vim.api

local M = {}

M.map = function(modes, keys, command, opt)
    local options = { silent = true, unique = true }

    if opt then
        options = vim.tbl_extend('force', options, opt)
    end

    if type(keys) == 'table' then
        for _, keymap in ipairs(keys) do
            M.map(modes, keymap, command, options)
        end
        return
    end

    vim.keymap.set(modes, keys, command, options)
end

local ft_augroup = api.nvim_create_augroup('ft_augroup', { clear = true })
M.ft_autocmd = function(filetypes, callback)
    api.nvim_create_autocmd('FileType', {
        group = ft_augroup,
        pattern = filetypes,
        callback = callback,
    })
end

M.with_pre_save = function(callback)
    return function()
        local buf = api.nvim_get_current_buf()
        api.nvim_buf_call(buf, function()
            vim.cmd('silent! write')
        end)
        callback()
    end
end

--- @type boolean
local is_workstation_cache = nil
--- @return boolean
M.is_workstation = function()
    if is_workstation_cache ~= nil then
        return is_workstation_cache
    end

    local output = vim.system({ 'yadm', 'config', '--get-all', 'local.class' }):wait()
    if output.code ~= 0 then
        is_workstation_cache = false
    elseif output.stdout:find('workstation') then
        is_workstation_cache = true
    else
        is_workstation_cache = false
    end
    return is_workstation_cache
end

--- @type boolean
local is_kitty_cache = nil
--- @return boolean
M.is_kitty = function()
    if is_kitty_cache ~= nil then
        return is_kitty_cache
    end

    local terminal = os.getenv('TERM')
    if terminal == 'xterm-kitty' then
        is_kitty_cache = true
    else
        is_kitty_cache = false
    end
    return is_kitty_cache
end

return M
