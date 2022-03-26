require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', "<C-f>", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<C-e>", "<cmd>Telescope oldfiles<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fo", "<cmd>Telescope oldfiles<cr>", { noremap = true })
vim.api.nvim_set_keymap('n', "<Leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })

-- TODO add more...
