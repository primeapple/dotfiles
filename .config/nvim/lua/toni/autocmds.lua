local api = vim.api

local yank_group = api.nvim_create_augroup('highlight_yank', {})
api.nvim_create_autocmd('TextYankPost', {
    command = 'silent! lua vim.highlight.on_yank({timeout=700})',
    group = yank_group,
})

api.nvim_create_autocmd(
    'BufReadPost',
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)
