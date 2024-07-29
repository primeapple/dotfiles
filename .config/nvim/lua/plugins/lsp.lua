local is_workstation = require('toni.utils').is_workstation

return {
    {
        'neovim/nvim-lspconfig',
        cond = is_workstation,
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'b0o/schemastore.nvim',
            -- TODO replace with https://github.com/folke/lazydev.nvim
            'folke/neodev.nvim',
        },

        config = function()
            require('neodev').setup({
                library = { plugins = { 'nvim-dap-ui' }, types = true },
            })

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
            utils.map('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')

            --- @param name string
            --- @param opts table?
            local server = function(name, opts)
                local merged_options = vim.tbl_deep_extend('force', {
                    on_attach = utils.on_attach,
                    capabilities = capabilities,
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
            server('stylelint_lsp')
            server('tailwindcss', {
                root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
            })
            server('tsserver', {
                root_dir = lsp.util.root_pattern('package.json'),
                init_options = {
                    preferences = {
                        importModuleSpecifierPreference = 'non-relative',
                        includeInlayParameterNameHints = 'all',
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayVariableTypeHints = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayEnumMemberValueHints = true,
                    },
                },
                --     autostart = false,
                -- })
                -- -- to avoid having tsserver run together with angularls, only start it if there is no `angular.json` found
                -- vim.api.nvim_create_autocmd('FileType', {
                --     pattern = 'typescript',
                --     callback = function(opt)
                --         local current_file_dir = vim.fn.expand('%:p')
                --         local client
                --         for _, item in ipairs(vim.lsp.get_active_clients()) do
                --             if item.name == 'tsserver' then
                --                 client = item
                --                 break
                --             end
                --         end
                --         local should_start = lsp.util.root_pattern('angular.json')(current_file_dir) == nil
                --         if client and should_start then
                --             vim.lsp.buf_attach_client(opt.buf, client)
                --         elseif not client and should_start then
                --             require('lspconfig.configs')['tsserver'].launch()
                --         end
                --     end,
                -- })
            })

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
        'mrcjkb/rustaceanvim',
        cond = is_workstation,
        version = '^4',
        ft = { 'rust' },
        config = function()
            local utils = require('toni.utils')
            vim.g.rustaceanvim = {
                server = {
                    on_attach = utils.on_attach,
                },
            }
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        cond = is_workstation,
        ft = { 'java' },
    },
    {
        'Olical/conjure',
        cond = is_workstation,
        dependencies = { 'benknoble/vim-racket' },
        ft = { 'racket' },
        config = function(_, opts)
            require('conjure.main').main()
            require('conjure.mapping')['on-filetype']()
        end,
    },
}
