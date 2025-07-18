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
            keymap = { preset = 'default' },
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
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
    },
}
