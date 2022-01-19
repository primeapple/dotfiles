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

""""""""""""""""""""""""
" Plugin Configuration "
""""""""""""""""""""""""
" Marks Nvim
lua <<EOF
require'marks'.setup {
  builtin_marks = { ".", "[", "]", "{", "}", "^" }
}
EOF
" Telescope Nvim
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
