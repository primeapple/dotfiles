local map = require('toni.utils').map

local M = {}

M.on_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ac', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>aa', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>af', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

    -- enable lsp_signature
    require('lsp_signature').on_attach({}, bufnr)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

local diagnostic_mappings = function ()
    map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    map('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')
end

local mason = function ()
    require('mason').setup({
        ui = {
            icons = {
                server_installed = '✓',
                server_pending = '➜',
                server_uninstalled = '✗'
            }
        }
    })
    require('mason-lspconfig').setup({
        automatic_installation = true
    })
end

local sumneko = function ()
    require('lspconfig').sumneko_lua.setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false
                },
            },
        },
    })
end

local eslint = function ()
    -- disables the EslintFixAll command, because it interferes with vim-projectionist
    require('lspconfig.server_configurations.eslint').commands = {};
    require('lspconfig').eslint.setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities
    })
end

local rust_analyzer = function ()
    require('lspconfig').rust_analyzer.setup({
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    allFeatures = true,
                    overrideCommand = {
                        'cargo', 'clippy', '--workspace', '--message-format=json',
                        '--all-targets', '--all-features'
                    }
                }
            }
        },
        on_attach = M.on_attach,
        capabilities = M.capabilities
    })
end

local tsserver = function ()
    local lsp = require('lspconfig')
    lsp.tsserver.setup({
        root_dir = lsp.util.root_pattern('package.json'),
        on_attach = M.on_attach,
        capabilities = M.capabilities
    })
end

local denols = function ()
    local lsp = require('lspconfig')
    lsp.denols.setup({
        root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
        on_attach = M.on_attach,
        capabilities = M.capabilities
    })
end

local server = function(language_server_name)
    require('lspconfig')[language_server_name].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities
    })
end

M.setup = function()
    diagnostic_mappings()
    mason()
    sumneko()
    eslint()
    rust_analyzer()
    tsserver()
    denols()
    server('stylelint_lsp')
    server('bashls')
    server('dockerls')
    server('tailwindcss')
end

return M
