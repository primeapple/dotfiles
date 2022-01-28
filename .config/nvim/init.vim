" install plugins using vim-plug
source $HOME/.config/nvim/plug.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

colorscheme dracula " default colorscheme
