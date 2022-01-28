" ======== SETTINGS ========
set nocompatible " enables ViImproved, not needed for Neovim, but hey

if has('filetype')
  filetype indent plugin on " enable plugins and indents for all files
endif
if has('syntax')
	syntax on " enable syntax on all files
endif
if has('mouse')
  set mouse=a " enable mouse
endif
if has("vms")
  set nobackup		" do not keep a backup file for git repos
else
  set backup		" keep a backup file for 
endif

set hidden " reuse window for multiple files
set wildmenu " commandline completion
set showcmd " show the commands in bottom line
set ruler " show the cursor position in the bottom
set hlsearch " search highlighting
set incsearch " search move highlighting while typing
set ignorecase " search ignore casing
set smartcase " search don't ignore casing on capital letters
set visualbell " visual bell instead of beep
" disable visual bell?
" set t_vb=
set autoindent " automatically indents
set backspace=indent,eol,start " Backspacing over everything
set history=500 " keep 500 lines of command line history
set number " enable line numbering
set relativenumber " enable relative line numbers
set nostartofline " keep cursor positioning
set shiftwidth=4 " 4 spaces for identation
set softtabstop=4 " Tab und Backspace use the correct number of spaces
set expandtab " tab gets converted to spaces
set clipboard=unnamedplus " default clipboard on Linux, Mac, Windows
set scrolloff=5 " autoscroll if on top or bottom
packadd matchit " add matchit plugin

" Don't use Ex mode, use Q for formatting
map Q gq

" in visual mode on insert don't overwrite default register with the
" overwritten word, see https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <silent> p p:let @+=@0<CR>

" set backupdir to neovim folder
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.
 
" set undodir to neovim folder
set undodir=~/.config/nvim/tmpm,.
set undofile

" Yank until eol
nnoremap Y yg_

" Keeping Cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Highlight until eol
nnoremap V vg_
nnoremap vv V

" Setting leader to space can be a bit tricky:
if has('nvim')
    " This one is for NVIM
    let mapleader = "\<Space>"
else
    " This one is for VIM
    noremap <Space> <Nop>
    map <Space> <Leader>
endif

" This unsets the 'last search pattern' register by hitting return
" https://stackoverflow.com/a/662914
nnoremap <silent> <CR> :noh<CR>

