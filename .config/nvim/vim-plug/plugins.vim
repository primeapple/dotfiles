" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
	" Not yet fully out of beta?
	" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " updating the parsers on update
    " File Explorer
    Plug 'scrooloose/NERDTree'
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
	" Latex Plugin
	Plug 'lervag/vimtex'
	" Auto closing brackets on enter key
	Plug 'rstacruz/vim-closer'

call plug#end()
