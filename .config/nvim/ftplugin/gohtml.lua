-- Treat gohtml exactly like html
vim.cmd("runtime! ftplugin/html.vim ftplugin/html/*.vim ftplugin/html/*.lua")
vim.cmd("runtime! syntax/html.vim")
vim.cmd("runtime! indent/html.vim")
vim.treesitter.language.register("html", "gohtml")
