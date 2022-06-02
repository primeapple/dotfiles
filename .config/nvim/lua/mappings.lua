local map = require('utils').map

map('n', 'V', 'vg_')
map('n', 'vv', 'V')
map('n', 'L', 'g_')
map('n', 'H', '^')
-- move lines up and down in visual mode
-- map('v', 'J', ''>+1<CR>gv=gv')
-- map('v', 'K', ''<-2<CR>gv=gv')
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

-- disabling q:
-- map('n', 'q:', '<nop>')
-- map('n', 'Q', 'q:')

-- allows "overpasting" selected blocks and not change the register to the overpasted text
map('v', 'p', 'p:let @+=@0<CR>')

-- close buffer, but leaves it in memory (oldfiles, bufferlist, marks, etc.)
map('n', '<leader>x', '<cmd> bd <CR>')
-- close buffer, wipeout everything about it
map('n', '<leader>X', '<cmd> bw <CR>')
