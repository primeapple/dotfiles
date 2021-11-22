" install plugins using vim-plug
source $HOME/.config/nvim/vim-plug/plugins.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

"BackupOrdner ändern
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

"UndoOrdner ändern
set undodir=~/.config/nvim/tmpm,.

"Farbschema ändern
colorscheme dracula
