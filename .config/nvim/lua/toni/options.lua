local opt = vim.opt
local g = vim.g

opt.confirm = true
opt.laststatus = 3 -- global statusline
opt.title = true
opt.clipboard = 'unnamedplus'
-- opt.cmdheight = 0 -- dont show commandline, comes in nvim 0.8?
opt.cmdheight = 1
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
opt.termguicolors = true
-- opt.timeoutlen = 400
opt.undofile = true
opt.scrolloff = 5

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

opt.lazyredraw = true

g.mapleader = ' '

-- It's not recommended to use fish for internal terminal, use it anyways because fish is amazing
-- opt.shell = "/bin/bash"
