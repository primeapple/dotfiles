return {
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
        version = '1.*',
        dependencies = {
            'moyiz/blink-emoji.nvim',
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = { auto_show = false },
                ghost_text = {
                    enabled = true,
                },
                menu = { auto_show = false },
            },
            keymap = { preset = 'enter' },
            sources = {
                default = {
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
                },
            },
            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
    },
}
