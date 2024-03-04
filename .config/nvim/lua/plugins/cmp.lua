return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'onsails/lspkind-nvim',
            -- sources
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-cmdline',
            {
                'zbirenbaum/copilot-cmp',
                dependencies = 'copilot.lua',
                config = function()
                    require('copilot_cmp').setup({
                        formatters = {
                            insert_text = require('copilot_cmp.format').remove_existing,
                        },
                    })
                end,
            },
            -- 'rcarriga/cmp-dap',
        },
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            cmp.setup({
                completion = {
                    autocomplete = false,
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        menu = {
                            buffer = '[BUF]',
                            nvim_lua = '[API]',
                            nvim_lsp = '[LSP]',
                            path = '[PATH]',
                            luasnip = '[SNIP]',
                            calc = '[CALC]',
                            emoji = '[EMO]',
                            copilot = '[COP]',
                            neorg = '[NORG]',
                        },
                    }),
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    {
                        name = 'buffer',
                        keyword_length = 3,
                        option = {
                            keyword_pattern = [[\k\+]],
                        },
                    },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
                    { name = 'copilot' },
                }),
                experimental = {
                    -- this breaks copilot.lua otherwise
                    ghost_text = false,
                },
            })

            -- only need a subset of the default sources in markdown
            cmp.setup.filetype('markdown', {
                sources = cmp.config.sources({
                    {
                        name = 'buffer',
                        keyword_length = 3,
                        option = {
                            keyword_pattern = [[\k\+]],
                        },
                    },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
                }),
            })

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    {
                        name = 'buffer',
                        option = {
                            keyword_pattern = [[\k\+]],
                        },
                    },
                    { name = 'path' },
                    { name = 'emoji' },
                    -- maybe add cmp-gitcommit ?
                }),
            })

            -- only need a subset of the default sources in neorg
            cmp.setup.filetype('norg', {
                sources = cmp.config.sources({
                    {
                        name = 'buffer',
                        keyword_length = 3,
                        option = {
                            keyword_pattern = [[\k\+]],
                        },
                    },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
                    { name = 'neorg' },
                }),
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })
        end,
    },
}
