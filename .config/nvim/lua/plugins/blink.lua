return {
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = '1.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'moyiz/blink-emoji.nvim',
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = { auto_show = true },
                ghost_text = {
                    enabled = true,
                },
                menu = {
                    auto_show = false,
                    draw = {
                        columns = {
                            { 'kind_icon' },
                            { 'label', 'label_description', gap = 1 },
                            { 'source_name' },
                        },
                    },
                },
            },
            keymap = {
                preset = 'default',
                ['<CR>'] = {
                    function(cmp)
                        if cmp.is_menu_visible() then
                            return cmp.accept()
                        end
                    end,
                    'fallback',
                },
            },
            sources = {
                default = {
                    'lazydev',
                    'lsp',
                    'path',
                    'snippets',
                    'buffer',
                    'emoji',
                },
                providers = {
                    emoji = {
                        module = 'blink-emoji',
                        name = 'Emoji',
                        score_offset = 15, -- Tune by preference
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                    },
                    snippets = {
                        min_keyword_length = 2,
                        score_offset = 4,
                    },
                    lazydev = {
                        min_keyword_length = 3,
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 3,
                    },
                    lsp = {
                        min_keyword_length = 3,
                        score_offset = 3,
                    },
                    path = {
                        min_keyword_length = 3,
                        score_offset = 2,
                    },
                    buffer = {
                        min_keyword_length = 5,
                        score_offset = 1,
                    },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
    },
}
