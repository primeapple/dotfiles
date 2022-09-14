local map = require('toni.utils').map

map('n', 'V', 'vg_')
map('n', 'vv', 'V')
map('n', 'L', 'g_')
map('n', 'H', '^')
-- keeping search results centered
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
-- keeping cursor on join centered
local function join()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd 'norm! J'
    vim.api.nvim_win_set_cursor(0, pos)
end
map('n', 'J', join)
map('n', '<ESC>', '<cmd> noh <CR>')

-- map({'n', 'x'}, ':', ';')
-- map({'n', 'x'}, ';', ':')
-- disabling q:
-- map('n', 'q:', '<nop>')
-- map('n', 'Q', 'q:')

-- allows "overpasting" selected blocks and not change the register to the overpasted text
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

