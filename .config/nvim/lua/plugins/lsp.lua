return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'b0o/schemastore.nvim',
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- use lsp as folding provider for `nvim-ufo`
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }

            local lsp = require('lspconfig')
            local utils = require('toni.utils')

            -- diagnostic mappings
            utils.map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
            utils.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
            utils.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
            utils.map('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')

            -- lsp stuff
            local server = function(language_server_name, options)
                local merged_options = vim.tbl_deep_extend('force', {
                    on_attach = utils.on_attach,
                    capabilities = capabilities,
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
                            enable = false,
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
                                'cargo',
                                'clippy',
                                '--workspace',
                                '--message-format=json',
                                '--all-targets',
                                '--all-features',
                            },
                        },
                    },
                },
            })
            server('tsserver', {
                root_dir = lsp.util.root_pattern('package.json'),
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'project-relative',
                    },
                },
            })
            server('denols', {
                root_dir = lsp.util.root_pattern('deno.json', 'deno.jsonc'),
            })
            server('volar')
            server('bashls')
            server('dockerls')
            server('tailwindcss', {
                root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
            })
            server('pyright')
            server('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            server('yamlls', {
                settings = {
                    yaml = {
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            })

            -- disables the EslintFixAll command, because it interferes with vim-projectionist
            require('lspconfig.server_configurations.eslint').commands = {}
            server('eslint')
        end,
    },
}
