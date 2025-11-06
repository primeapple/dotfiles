local opt = vim.opt
local g = vim.g
local o = vim.o

opt.confirm = true
opt.laststatus = 3 -- global statusline
opt.title = true
opt.clipboard = 'unnamedplus'
opt.cmdheight = 0 -- dont show commandline, for more space
opt.modeline = false
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true

opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = 'a'

-- Numbers
opt.number = true
opt.numberwidth = 2
-- disabling for now to learn leap
-- opt.relativenumber = true
opt.ruler = false

opt.signcolumn = 'yes'
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen'
opt.tabstop = 4
opt.softtabstop = 4
-- opt.timeoutlen = 400
opt.undofile = true
opt.scrolloff = 5
-- TODO only enable that for qf windows and so on
-- opt.winfixbuf = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- disable for noice
-- opt.lazyredraw = true

g.mapleader = ' '
g.maplocalleader = ','

-- Make <C-A> and <C-X> work better on numbers with strings with "-" before the number, like "sprint-1"
opt.nrformats:append('blank')

-- It's not recommended to use fish for internal terminal, therefore let's set it to bash
opt.shell = '/bin/bash'

-- Since I use AutoSave this should be save to use
o.autoread = true

---- Nice and simple folding - https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ''
vim.opt.foldcolumn = '0'
vim.opt.fillchars:append({ fold = ' ' })
vim.o.foldmethod = 'expr'
-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
})
