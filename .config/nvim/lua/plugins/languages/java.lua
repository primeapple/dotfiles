return {
    'mfussenegger/nvim-jdtls',
    cond = require('toni.utils').is_workstation,
    ft = 'java',
    config = function()
        vim.lsp.config("jdtls", {
            settings = {
                java = {
                    -- Custom eclipse.jdt.ls options go here
                },
            },
        })
        vim.lsp.enable("jdtls")
    end,
}
