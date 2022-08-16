vim.cmd( [[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
    augroup END
]])
-- open vim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- toggling tmux on viminsert/exit
-- vim.cmd ([[
--     if has_key(environ(), 'TMUX')
--         augroup tmux_something
--             autocmd VimResume  * call system('tmux set status off')
--             autocmd VimEnter   * call system('tmux set status off')
--             autocmd VimLeave   * call system('tmux set status on')
--             autocmd VimSuspend * call system('tmux set status on')
--         augroup END
--     endif
-- ]])
