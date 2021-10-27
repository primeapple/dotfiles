" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
	" Nice color scheme
	Plug 'dracula/vim'
	" Sorround
	Plug 'tpope/vim-surround'
	" Commentary
	Plug 'tpope/vim-commentary'
	" Multiple Cursors
	Plug 'mg979/vim-visual-multi'
	" Highlights yanked text
	Plug 'machakann/vim-highlightedyank'

call plug#end()
