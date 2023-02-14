local map = require('toni.utils').map

map('n', 'V', 'vg_')
map('n', 'vv', 'V')
map({'n', 'x', 'o'}, 'L', 'g_')
map({'n', 'x', 'o'}, 'H', '^')

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

map('n', '<ESC>', '<cmd> noh <CR>')

-- map({'n', 'x'}, ':', ';')
-- map({'n', 'x'}, ';', ':')
-- disabling q:
-- map('n', 'q:', '<nop>')
-- map('n', 'Q', 'q:')

-- allows 'overpasting' selected blocks and not change the register to the overpasted text
map('v', 'p', 'p:let @+=@0<CR>')

-- Redo with U
map('n', 'U', '<C-R>')

-- close window
map('n', '<leader>x', '<cmd> q <CR>')
-- close all windows
-- map('n', '<leader>X', '<cmd> qa <CR>')

-- open new vertical split
map('n', '<leader>/', '<cmd> vsp <CR>')
-- open new horizontal split
map('n', '<leader>-', '<cmd> sp <CR>')

-- get out of terminal mode
map('t', '<ESC><ESC>', '<C-\\><C-n>')

-- Remap for dealing with visual line wraps
-- Doesn't seem to work?
-- TODO investigate
-- map("n", "j", function() return vim.v.count > 0 and 'j' or 'gj' end, { expr = true })
-- map("n", "k", function() return vim.v.count > 0 and 'k' or 'gk' end, { expr = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

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
map('n', '<leader>q', toggle_qf)

-- rename word under cursor
-- map('n', '<F4>', ':%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i')
