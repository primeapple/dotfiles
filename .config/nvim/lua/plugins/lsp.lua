local on_attach = function(client, bufnr)
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
end

return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            -- mason stuff
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

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lsp = require('lspconfig')

            -- lsp stuff
            local server = function(language_server_name, options)
                local merged_options = vim.tbl_deep_extend('force', {
                    on_attach = on_attach,
                    capabilities = capabilities
                }, options or {})

                lsp[language_server_name].setup(merged_options)
            end

            server('lua_ls', {
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
            server('rust_analyzer', {
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
                    }
            })
            server('tsserver', {
                root_dir = lsp.util.root_pattern('package.json'),
            })
            server('denols', {
                root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
            })
            server('volar')
            server('bashls')
            server('dockerls')
            server('tailwindcss')
            server('pyright')

            -- disables the EslintFixAll command, because it interferes with vim-projectionist
            require('lspconfig.server_configurations.eslint').commands = {};
            server('eslint')

            -- diagnostic mappings
            local map = require('toni.utils').map
            map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
            map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
            map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
            map('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')

        end
    }
}
