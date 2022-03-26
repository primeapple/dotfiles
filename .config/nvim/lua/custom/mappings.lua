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
-- managing harpoons
-- TODO: replace with Lua functions
-- nnoremap <silent><Leader>hh :lua require("harpoon.mark").toggle_file()<CR>
-- nnoremap <silent><Leader>ha :lua require("harpoon.mark").add_file()<CR>
-- nnoremap <silent><Leader>hd :lua require("harpoon.mark").add_file()<CR>
-- nnoremap <silent><Leader>hm :lua require("harpoon.ui").toggle_quick_menu()<CR>
-- nnoremap <silent><Leader>hc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>
--
-- nnoremap <silent><C-1> :lua require("harpoon.ui").nav_file(1)<CR>
-- nnoremap <silent><C-2> :lua require("harpoon.ui").nav_file(2)<CR>
-- nnoremap <silent><C-3> :lua require("harpoon.ui").nav_file(3)<CR>
-- nnoremap <silent><C-4> :lua require("harpoon.ui").nav_file(4)<CR>
-- nnoremap <silent><C-5> :lua require("harpoon.ui").nav_file(5)<CR>
-- nnoremap <silent><C-6> :lua require("harpoon.ui").nav_file(6)<CR>
-- nnoremap <silent><C-7> :lua require("harpoon.ui").nav_file(7)<CR>
-- nnoremap <silent><C-8> :lua require("harpoon.ui").nav_file(8)<CR>
-- nnoremap <silent><C-9> :lua require("harpoon.ui").nav_file(9)<CR>
-- nnoremap <silent><C-0> :lua require("harpoon.ui").nav_file(0)<CR>
--
-- nnoremap <silent><Leader>h1 :lua require("harpoon.ui").nav_file(1)<CR>
-- nnoremap <silent><Leader>h2 :lua require("harpoon.ui").nav_file(2)<CR>
-- nnoremap <silent><Leader>h3 :lua require("harpoon.ui").nav_file(3)<CR>
-- nnoremap <silent><Leader>h4 :lua require("harpoon.ui").nav_file(4)<CR>
-- nnoremap <silent><Leader>h5 :lua require("harpoon.ui").nav_file(5)<CR>
-- nnoremap <silent><Leader>h6 :lua require("harpoon.ui").nav_file(6)<CR>
-- nnoremap <silent><Leader>h7 :lua require("harpoon.ui").nav_file(7)<CR>
-- nnoremap <silent><Leader>h8 :lua require("harpoon.ui").nav_file(8)<CR>
-- nnoremap <silent><Leader>h9 :lua require("harpoon.ui").nav_file(9)<CR>
-- nnoremap <silent><Leader>h0 :lua require("harpoon.ui").nav_file(0)<CR>
