" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
	" TODO: Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " updating the parsers on update
	" Nice color scheme
	Plug 'dracula/vim'
	" Surround
	Plug 'tpope/vim-surround'
	" Commentary
	Plug 'tpope/vim-commentary'
	" Git support in Vim
	Plug 'tpope/vim-fugitive'
	" Useful mappings with [ and ]
	Plug 'tpope/vim-unimpaired'
	" Lua Functions, required by telescope and harpoon
	Plug 'nvim-lua/plenary.nvim'
	" Fuzzy Finder
	Plug 'nvim-telescope/telescope.nvim'
	" Highlights yanked text
	Plug 'machakann/vim-highlightedyank'
	" Latex Plugin
	Plug 'lervag/vimtex'
	" Auto closing brackets on enter key
	Plug 'rstacruz/vim-closer'
	" move through camelCase, snake_case, kebab-case, CONSTANTS, ... with w, e, b, ge, aw, iw
	Plug 'chaoren/vim-wordmotion'
	" better marks (visualization, deletion, navigation, etc.)
	Plug 'chentau/marks.nvim'
	" Neovim im Browser :O
	Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

