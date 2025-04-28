return {
    {
        'hrsh7th/nvim-cmp',
        enabled = false,
        dependencies = {
            'onsails/lspkind-nvim',
            'L3MON4D3/LuaSnip',
            -- sources
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            -- 'rcarriga/cmp-dap',
        },
        event = 'InsertEnter',
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local ls = require('luasnip')

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
                    ['<CR>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            if ls.expandable() then
                                ls.expand()
                            else
                                cmp.confirm({
                                    behavior = cmp.ConfirmBehavior.Insert,
                                    select = true,
                                })
                            end
                        else
                            fallback()
                        end
                    end, { 'i' }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if ls.locally_jumpable(1) then
                            ls.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if ls.locally_jumpable(-1) then
                            ls.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    {
                        name = 'buffer',
                        keyword_length = 5,
                        option = {
                            keyword_pattern = [[\k\+]],
                        },
                    },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                    { name = 'calc' },
                    { name = 'emoji' },
                    { name = 'nvim-cmp-ts-tag-close' },
                }),
                experimental = {
                    -- this breaks copilot.lua if enabled
                    ghost_text = true,
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
        end,
    },
}
