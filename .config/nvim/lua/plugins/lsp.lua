local is_workstation = require('toni.utils').is_workstation

return {
    {
        'neovim/nvim-lspconfig',
        cond = is_workstation,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'b0o/schemastore.nvim',
        },

        config = function()
            local lsp = require('lspconfig')
            local utils = require('toni.utils')

            -- diagnostic mappings
            utils.map('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
            utils.map('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')

            --- @param name string
            --- @param opts table?
            local server = function(name, opts)
                local merged_options = vim.tbl_deep_extend('force', {
                    on_attach = utils.on_attach,
                }, opts or {})

                lsp[name].setup(merged_options)
            end

            server('angularls')
            server('astro')
            server('bashls')
            server('biome')
            server('dockerls')
            server('eslint', {
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'javascript.jsx',
                    'typescript',
                    'typescriptreact',
                    'typescript.tsx',
                    'vue',
                    'svelte',
                    'astro',
                    'html',
                },
            })
            server('gopls')
            server('harper-ls')
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
                        hint = {
                            enable = true,
                            setType = true,
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
            server('phpactor')
            server('pyright')
            server('rust_analyzer')
            server('stylelint_lsp')
            server('tailwindcss', {
                root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
            })
            -- server('vtsls', {
            --     settings = {
            --         complete_function_calls = true,
            --         vtsls = {
            --             enableMoveToFileCodeAction = true,
            --             autoUseWorkspaceTsdk = true,
            --             experimental = {
            --                 completion = {
            --                     enableServerSideFuzzyMatch = true,
            --                 },
            --                 -- maxInlayHintLength = 100,
            --             },
            --         },
            --         typescript = {
            --             updateImportsOnFileMove = { enabled = 'always' },
            --             suggest = {
            --                 completeFunctionCalls = true,
            --             },
            --             inlayHints = {
            --                 enumMemberValues = { enabled = true },
            --                 functionLikeReturnTypes = { enabled = true },
            --                 parameterNames = { enabled = 'literals' },
            --                 parameterTypes = { enabled = true },
            --                 propertyDeclarationTypes = { enabled = true },
            --                 variableTypes = { enabled = false },
            --             },
            --         },
            --     },
            -- })

            server('yamlls', {
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = '',
                        },
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            })
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        cond = is_workstation,
        ft = { 'java' },
    },
}
