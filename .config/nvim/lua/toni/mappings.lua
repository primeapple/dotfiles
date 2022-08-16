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

-- close window
map('n', '<leader>x', '<cmd> q <CR>')
-- close all windows
-- map('n', '<leader>X', '<cmd> qa <CR>')

-- open new vertical split
map('n', '<leader>/', '<cmd> vsp <CR>')
-- open new horizontal split
map('n', '<leader>-', '<cmd> sp <CR>')

-- get out of terminal mode
map('t', '<ESC>', '<C-\\><C-n>')

-- moving around splits with <C-hjkl>
-- Terminal mode:
map('t', '<C-h>', '<C-\\><C-n><C-w>h')
map('t', '<C-j>', '<C-\\><C-n><C-w>j')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')
map('t', '<C-l>', '<C-\\><C-n><C-w>l')
-- Insert mode:
map('i', '<C-h>', '<Esc><C-w>h')
map('i', '<C-j>', '<Esc><C-w>j')
map('i', '<C-k>', '<Esc><C-w>k')
map('i', '<C-l>', '<Esc><C-w>l')
-- Visual mode:
map('v', '<C-h>', '<Esc><C-w>h')
map('v', '<C-j>', '<Esc><C-w>j')
map('v', '<C-k>', '<Esc><C-w>k')
map('v', '<C-l>', '<Esc><C-w>l')
-- Normal mode:
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
