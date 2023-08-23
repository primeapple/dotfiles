local api = vim.api

local group = api.nvim_create_augroup('highlight_yank', { clear = true })

-- highlight after yanking
api.nvim_create_autocmd('TextYankPost', {
    group = group,
    command = 'silent! lua vim.highlight.on_yank({timeout=700})',
})

-- restore last position after opening buffer
api.nvim_create_autocmd('BufReadPost', {
    group = group,
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})
