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

    local opts = { noremap = true, silent = true }

    -- api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)

    api.nvim_buf_set_keymap(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    api.nvim_buf_set_keymap(
        bufnr,
        'n',
        '<leader>sl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
        opts
    )
    api.nvim_buf_set_keymap(
        bufnr,
        'n',
        'yoi',
        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>',
        opts
    )

    -- TODO is the default in nvim 0.11
    api.nvim_buf_set_keymap(bufnr, 'n', 'crn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    api.nvim_buf_set_keymap(bufnr, 'n', 'crr', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
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

return M
