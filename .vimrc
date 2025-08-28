" ======== SETTINGS ========
set nocompatible " enables ViImproved
if has('filetype')
    filetype indent plugin on " enable plugins and indents for all files
endif
if has('syntax')
    syntax on " enable syntax on all files
endif
if has('mouse')
    set mouse=a " enable mouse
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
set nostartofline " keep cursor positioning
set shiftwidth=4 " 4 spaces for identation
set softtabstop=4 " Tab und Backspace use the correct number of spaces
set expandtab " tab gets converted to spaces
set clipboard=unnamedplus " default clipboard on Linux, Mac, Windows
set scrolloff=10 " autoscroll if on top or bottom
set splitbelow " open horizontal splits below
set splitright " open vertical splits right
set undofile " keeps undofile
packadd matchit " add matchit plugin
" jump to last opened line unless position is invalid
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

""""""""""""""""
""" Mappings """
""""""""""""""""
" Don't use Ex mode, use Q for formatting
map Q gq

" in visual mode on insert don't overwrite default register with the
" overwritten word, see https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <silent> p p:let @+=@0<CR>
 
" Yank until eol
nnoremap Y yg_

" Keeping Cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
" TODO: replace with lua function
nnoremap <silent> J mzJ`z

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Highlight until eol
nnoremap V vg_
nnoremap vv V

" This should be done in init.lua or .ideavimrc
" Setting leader to space can be a bit tricky:
" if has('nvim')
"     " This one is for NVIM
"     let mapleader = "\<Space>"
" else
"     " This one is for VIM
"     noremap <Space> <Nop>
"     map <Space> <Leader>
" endif

" This unsets the 'last search pattern' register by hitting return
" https://stackoverflow.com/a/662914
nnoremap <silent> <ESC> :noh<CR>

nnoremap H ^
nnoremap L g_

" Omnicomplete with C-Space
" imap <c-space> <c-x><c-o>

nnoremap U <C-R>

" Window navigation
nnoremap <C-Left> <C-w>h
nnoremap <C-h> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-l> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-k> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <C-j> <C-w>j
inoremap <C-Left> <Esc><C-w>h
inoremap <C-h> <Esc><C-w>h
inoremap <C-Right> <Esc><C-w>l
inoremap <C-l> <Esc><C-w>l
inoremap <C-Up> <Esc><C-w>k
inoremap <C-k> <Esc><C-w>k
inoremap <C-Down> <Esc><C-w>j
inoremap <C-j> <Esc><C-w>j
xnoremap <C-Left> <Esc><C-w>h
xnoremap <C-h> <Esc><C-w>h
xnoremap <C-Right> <Esc><C-w>l
xnoremap <C-l> <Esc><C-w>l
xnoremap <C-Up> <Esc><C-w>k
xnoremap <C-k> <Esc><C-w>k
xnoremap <C-Down> <Esc><C-w>j
xnoremap <C-j> <Esc><C-w>j
