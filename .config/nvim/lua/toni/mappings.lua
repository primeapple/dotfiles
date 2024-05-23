local map = require('toni.utils').map

map('n', 'V', 'vg_')
map('n', 'vv', 'V')
map({ 'n', 'x', 'o' }, { 'L', '<S-Right>' }, 'g_')
map({ 'n', 'x', 'o' }, { 'H', '<S-Left>' }, '^')

-- keeping search results centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- keeping cursor on join centered
-- local function join()
--     local pos = vim.api.nvim_win_get_cursor(0)
--     vim.cmd 'norm! J'
--     vim.api.nvim_win_set_cursor(0, pos)
-- end
-- map('n', 'J', join)

map('n', '<ESC>', '<cmd> noh <CR> <cmd> echo <CR>')

-- map({'n', 'x'}, ':', ';')
-- map({'n', 'x'}, ';', ':')
-- disabling q:
-- map('n', 'q:', '<nop>')
-- map('n', 'Q', 'q:')

-- allows 'overpasting' selected blocks and not change the register to the overpasted text
map('x', 'p', 'p:let @+=@0<CR>')

-- open new vertical split
map('n', '<leader>/', '<cmd> vsp <CR>')
-- open new horizontal split
map('n', '<leader>-', '<cmd> sp <CR>')
-- readjust splits
map('n', '<leader>=', '<C-w>=')

-- get out of terminal mode
map('t', '<ESC><ESC>', '<C-\\><C-n>')

-- Remap for dealing with visual line wraps
map('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end, { expr = true })
map('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end, { expr = true })

-- better indenting
map('x', '<', '<gv')
map('x', '>', '>gv')

local function toggle_qf()
    local open_buffers = vim.api.nvim_list_bufs()
    for _, buf_num in ipairs(open_buffers) do
        if vim.api.nvim_buf_get_option(buf_num, 'filetype') == 'qf' then
            local buf_loaded = vim.api.nvim_buf_is_loaded(buf_num)
            vim.api.nvim_command(buf_loaded and 'cclose' or 'cwindow')
            return
        end
    end
    vim.api.nvim_command('cwindow')
end
map('n', 'ZC', toggle_qf)

-- rename word under cursor
-- map('n', '<F4>', ':%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i')

-- nicer save
map('n', 'ZW', '<cmd> w <CR>')
map('n', 'ZA', '<cmd> wa <CR>')

-- stolen from mini.basics
map('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
map('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")
