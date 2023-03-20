return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'RRethy/nvim-treesitter-textsubjects',
            {
                'nvim-treesitter/playground',
                cmd = 'TSPlaygroundToggle'
            }
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'bash',
                    'css',
                    'dockerfile',
                    'fish',
                    'help',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'nix',
                    'python',
                    'query',
                    'regex',
                    'ruby',
                    'rust',
                    'scss',
                    'svelte',
                    'tsx',
                    'typescript',
                    'vim',
                    'vue',
                    'yaml',
                },
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    additional_vim_regex_highlighting = false,
                },
                -- EXPERIMENTAL
                indent = {
                    enable = true
                },
                -- for nvim-treesitter-textsubjects
                textsubjects = {
                    enable = true,
                    prev_selection = ',', -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        ['a;'] = 'textsubjects-container-outer',
                        ['i;'] = 'textsubjects-container-inner',
                    },
                },
                -- for vim-matchup
                matchup = {
                    enable = true
                },
            })

        end
    }
}
