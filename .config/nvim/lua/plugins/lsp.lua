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
            utils.map('n', '<leader>d', vim.diagnostic.open_float)
            utils.map('n', '<leader>D', vim.diagnostic.setloclist)

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('grr', require('telescope.builtin').lsp_references, 'LSP: [G]oto [R]eferences in Telescope')
                    map('grR', vim.lsp.buf.references, 'LSP: [G]oto [R]eferences in Quickfix')
                    map('gri', require('telescope.builtin').lsp_implementations, 'LSP: [G]oto [I]mplementation')
                    map('gd', require('telescope.builtin').lsp_definitions, 'LSP: [G]oto [D]efinition')
                    map('gD', '<cmd>vsplit | lua vim.lsp.buf.definition() <CR>', 'LSP: [G]oto [D]efinition in Split')
                    map('gO', require('telescope.builtin').lsp_document_symbols, 'LSP: Open Document Symbols')
                    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'LSP: Open Workspace Symbols')
                    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
                    then
                        map('yoi', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                        end, 'LSP: Toggle Inlay Hints')
                    end
                end,
            })

            vim.lsp.enable('astro')
            vim.lsp.enable('bashls')
            vim.lsp.enable('biome')
            vim.lsp.enable('dockerls')
            vim.lsp.config('eslint', {
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
                },
            })
            vim.lsp.enable('eslint')
            vim.lsp.enable('gopls')
            vim.lsp.enable('harper_ls')
            vim.lsp.enable('html')
            vim.lsp.config('jsonls', {
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable('jsonls')
            vim.lsp.enable('kotlin_lsp')
            vim.lsp.config('lua_ls', {
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
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('stylelint_lsp')
            vim.lsp.config('tailwindcss', {
                root_dir = lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts'),
            })
            vim.lsp.enable('tailwindcss')
            vim.lsp.config('vtsls', {
                settings = {
                    complete_function_calls = true,
                    vtsls = {
                        enableMoveToFileCodeAction = true,
                        autoUseWorkspaceTsdk = true,
                        experimental = {
                            completion = {
                                enableServerSideFuzzyMatch = true,
                            },
                            maxInlayHintLength = 100,
                        },
                    },
                    typescript = {
                        updateImportsOnFileMove = { enabled = 'always' },
                        suggest = {
                            completeFunctionCalls = true,
                        },
                        inlayHints = {
                            enumMemberValues = { enabled = true },
                            functionLikeReturnTypes = { enabled = true },
                            parameterNames = { enabled = 'literals' },
                            parameterTypes = { enabled = true },
                            propertyDeclarationTypes = { enabled = true },
                            variableTypes = { enabled = false },
                        },
                    },
                },
            })
            vim.lsp.enable('vtsls')

            vim.lsp.config('yamlls', {
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
            vim.lsp.enable('yamlls')
        end,
    },
    {
        'mfussenegger/nvim-jdtls',
        cond = is_workstation,
        ft = { 'java' },
    },
}
