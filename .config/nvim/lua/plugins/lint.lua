return {
    'mfussenegger/nvim-lint',
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            dockerfile = { 'hadolint' },
            fish = { 'fish' },
            yaml = { 'yamllint' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
                lint.try_lint('woke')
            end,
        })
    end,
}
