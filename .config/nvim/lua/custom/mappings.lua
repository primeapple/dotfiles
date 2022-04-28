local map = require("core.utils").map

map("n", "V", "vg_")
map("n", "vv", "V")
map("n", "L", "g_")
map("n", "H", "^")
-- move lines up and down in visual mode
map("v", "J", "'>+1<CR>gv=gv")
map("v", "K", "'<-2<CR>gv=gv")
-- keeping search results centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- TODO: replace with lua function below
map("n", "J", "mzJ`z", { silent = true })
-- until new version with following pull is live
-- https://github.com/neovim/neovim/pull/16591
-- vim.keymap.set('n', 'J', join)
local function join()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd "norm! J"
    vim.api.nvim_win_set_cursor(0, pos)
end

-- Telescope
map("n", "<leader>F", ":Telescope <CR>")

-- managing harpoons
-- TODO: replace with Lua functions
map("n", "gh", ":lua require('harpoon.mark').toggle_file() <CR>", { silent = true })
map("n", "]h", ":lua require('harpoon.ui').nav_next() <CR>", { silent = true })
map("n", "[h", ":lua require('harpoon.ui').nav_prev() <CR>", { silent = true })
map("n", "gH", ":lua require('harpoon.ui').toggle_quick_menu() <CR>", { silent = true })
map("n", "<leader>fH", ":Telescope harpoon marks <CR>", { silent = true })
-- map("n", "gt", ":lua require('harpoon.cmd-ui').toggle_quick_menu() <CR>", { silent = true })
-- TODO: add an expression to call like 1gh or gh1
-- map("n", "gh", ":lua require('harpoon.ui').nav_file(vim.v.count) <CR>", { expr = true, silent = true })
map("n", "gh1", ":lua require('harpoon.ui').nav_file(1) <CR>", { silent = true })
map("n", "gh2", ":lua require('harpoon.ui').nav_file(2) <CR>", { silent = true })
map("n", "gh3", ":lua require('harpoon.ui').nav_file(3) <CR>", { silent = true })
map("n", "gh4", ":lua require('harpoon.ui').nav_file(4) <CR>", { silent = true })
map("n", "gh5", ":lua require('harpoon.ui').nav_file(5) <CR>", { silent = true })
map("n", "gh6", ":lua require('harpoon.ui').nav_file(6) <CR>", { silent = true })
map("n", "gh7", ":lua require('harpoon.ui').nav_file(7) <CR>", { silent = true })
map("n", "gh8", ":lua require('harpoon.ui').nav_file(8) <CR>", { silent = true })
map("n", "gh9", ":lua require('harpoon.ui').nav_file(9) <CR>", { silent = true })

-- these mappings don't work yet...
-- map("n", "<C-1>", ":lua require('harpoon.ui').nav_file(1) <CR>", { silent = true })
-- map("n", "<C-2>", ":lua require('harpoon.ui').nav_file(2) <CR>", { silent = true })
-- map("n", "<C-3>", ":lua require('harpoon.ui').nav_file(3) <CR>", { silent = true })
-- map("n", "<C-4>", ":lua require('harpoon.ui').nav_file(4) <CR>", { silent = true })
-- map("n", "<C-5>", ":lua require('harpoon.ui').nav_file(5) <CR>", { silent = true })
-- map("n", "<C-6>", ":lua require('harpoon.ui').nav_file(6) <CR>", { silent = true })
-- map("n", "<C-7>", ":lua require('harpoon.ui').nav_file(7) <CR>", { silent = true })
-- map("n", "<C-8>", ":lua require('harpoon.ui').nav_file(8) <CR>", { silent = true })
-- map("n", "<C-9>", ":lua require('harpoon.ui').nav_file(9) <CR>", { silent = true })

