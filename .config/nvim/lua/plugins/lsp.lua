return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            -- language specific tooling
            'b0o/schemastore.nvim',
            'folke/neodev.nvim'
        },
        config = function()
            require('neodev').setup({})

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

            local server = function(language_server_name, options)
                local merged_options = vim.tbl_deep_extend('force', {
                    on_attach = utils.on_attach,
                    capabilities = capabilities,
                }, options or {})

                lsp[language_server_name].setup(merged_options)
            end

            server('angularls')
            server('astro')
            server('bashls')
            server('dockerls')
            server('eslint')
            server('gopls')
            server('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            server('lua_ls', {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
            server('pyright')
            server('rome', {
                root_dir = lsp.util.root_pattern('rome.json'),
                single_file_support = false,
            })
            server('stylelint_lsp')
            server('tailwindcss', {
                root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
            })
            server('tsserver', {
                root_dir = lsp.util.root_pattern('package.json'),
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'shortest',
                    },
                },
            })
            server('volar')
            server('yamlls', {
                settings = {
                    yaml = {
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            })
        end,
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        ft = { 'rust' },
        config = function()
            local utils = require('toni.utils')
            vim.g.rustaceanvim = {
                server = {
                    on_attach = utils.on_attach
                },
            }
        end
    },
    {
        'mfussenegger/nvim-jdtls'
    }
}
