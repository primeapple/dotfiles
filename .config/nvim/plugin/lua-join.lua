local function join()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd "norm! J"
  vim.api.nvim_win_set_cursor(0, pos)
end
-- until new version with following pull is live
-- https://github.com/neovim/neovim/pull/16591
-- vim.keymap.set('n', 'J', join)
