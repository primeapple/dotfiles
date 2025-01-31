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

-- It's not recommended to use fish for internal terminal, therefore let's set it to bash
opt.shell = '/bin/bash'

-- Since I use AutoSave this should be save to use
o.autoread = true
