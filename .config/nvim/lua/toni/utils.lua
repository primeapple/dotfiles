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

M.on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr })
    end

    M.map('n', 'crr', vim.lsp.buf.code_action, { buffer = bufnr })
    M.map('n', 'crn', vim.lsp.buf.rename, { buffer = bufnr })
    M.map('n', 'gR', vim.lsp.buf.references, { buffer = bufnr })
    M.map('n', 'gD', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
    M.map('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
    M.map('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr })

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
        M.map('n', 'yoi', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
        end, { buffer = bufnr })
    end
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

return M
