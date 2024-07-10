return {
    'mfussenegger/nvim-lint',
    cond = require('toni.utils').is_workstation,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
    },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            dockerfile = { 'hadolint' },
            fish = { 'fish' },
            sh = { 'shellcheck' },
            yaml = { 'yamllint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
                -- lint.try_lint('woke')
            end,
        })
    end,
}
