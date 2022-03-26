require('nvim-treesitter.configs').setup {
    -- Maybe change to list of languages
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
    },
    -- EXPERIMENTAL
    indent = {
        enable = true
    }
}
