local TS_LANGUAGES = {
    'angular',
    'bash',
    'c',
    'css',
    'dockerfile',
    'diff',
    'fish',
    'go',
    'html',
    'http',
    'java',
    'javascript',
    'json',
    'kotlin',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'nix',
    'php',
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
}

return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-context',
        -- sadly not supported with new Treesitter branch: https://github.com/RRethy/nvim-treesitter-textsubjects/issues/52
        -- 'RRethy/nvim-treesitter-textsubjects',
    },
    config = function()
        --  taken from https://github.com/MeanderingProgrammer/treesitter-modules.nvim

        require('nvim-treesitter').install(TS_LANGUAGES)
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('treesitter.setup', {}),
            callback = function(args)
                local buf = args.buf
                local filetype = args.match

                -- you need some mechanism to avoid running on buffers that do not
                -- correspond to a language (like oil.nvim buffers), this implementation
                -- checks if a parser exists for the current language
                local language = vim.treesitter.language.get_lang(filetype) or filetype
                if not vim.treesitter.language.add(language) then
                    return
                end

                -- enable folding
                vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

                -- enable highlighting
                vim.treesitter.start(buf, language)

                -- enable indenting
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
