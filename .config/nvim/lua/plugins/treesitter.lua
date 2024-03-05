return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        version = false,
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = {
            'nvim-treesitter/nvim-treesitter-context',
            'RRethy/nvim-treesitter-textsubjects',
        },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    'angular',
                    'bash',
                    'c',
                    'css',
                    'dockerfile',
                    'fish',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'lua',
                    'luadoc',
                    'luap',
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
                    'toml',
                    'tsx',
                    'typescript',
                    'vim',
                    'vimdoc',
                    'vue',
                    'yaml',
                },
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
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
                    enable = true,
                },
            })
            require('treesitter-context').setup()
        end,
    },
}
