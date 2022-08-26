require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'bash',
        'css',
        'dockerfile',
        'fish',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'nix',
        'python',
        'regex',
        'ruby',
        'rust',
        'scss',
        'svelte',
        'tsx',
        'typescript',
        'vim',
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
    -- for nvim-treesitter-textobjects
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
            -- v = char, V = line, <c-v> = block (default is 'v')
            -- this seems not to work?
            -- selection_modes = {
            --     ['@parameter.outer'] = 'v', -- charwise
            --     ['@function.outer'] = 'V', -- linewise
            --     ['@class.outer'] = '<c-v>', -- blockwise
            -- },
        },
        move = {
            enable = true,
            set_jumps = false, -- whether to set jumps in the jumplist
            goto_next_start = {
                [']m'] = '@function.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
            },
        },
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
    }
})

