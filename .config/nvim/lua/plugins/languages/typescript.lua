local is_workstation = require('toni.utils').is_workstation
local utils = require('toni.utils')

return {
    'dmmulroy/tsc.nvim',
    cond = is_workstation,
    cmd = 'TSC',
    opts = {
        -- enable_progress_notifications = false,
    },
    {
        'pmizio/typescript-tools.nvim',
        ft = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'vue',
            'svelte',
            'astro',
        },
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
        opts = {
            on_attach = utils.on_attach,
        },
    },
}
