local M = {}

M.setup_lsp = function(attach, capabilities)
    local lspconfig = require("lspconfig")

    -- lspservers with default config
    local servers = {
        "bashls",
        "cssls",
        "dockerls",
        "eslint",
        "html",
        "pyright",
        -- special install script needed
        -- "sumneko_lua",
        -- check sqls, it seems to be a better alternative
        "sqlls",
        "tsserver",
    }
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = attach,
            capabilities = capabilities,
            flags = {
                -- This will be the default in neovim 0.7+
                debounce_text_changes = 150,
            },
        }
    end
end

return M
