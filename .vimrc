set nocompatible              " be iMproved, required
filetype off                  " required

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif



" Add optional packages.

" hier werden die Tabulatoreinstellungen gemacht
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
"set expandtab

"Zeilennummerierung anschalten:
set number
set relativenumber

"Systemclipboard wird statt dem VIM Clipboard genutzt
set clipboard=unnamedplus
" in visual mode on insert don't overwrite default register with the
" overwritten word, see https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
xnoremap <silent> p p:let @+=@0<CR>

"BackupOrdner ändern
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.
 
"UndoOrdner ändern
set undodir=~/.config/nvim/tmpm,.
set undofile

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

"Toggle Methoden einfügen, dabei werden immer abwechselnd erst das eine, dann
"das andere Kommando ausgeführt, egal, welche Taste von beiden gedrückt wird:
function! ToggleMovement(firstOp, thenOp)
  let pos = getpos('.')
  execute "normal! " . a:firstOp
  if pos == getpos('.')
    execute "normal! " . a:thenOp
  endif
endfunction

" The original carat 0 swap
nnoremap <silent> 0 :call ToggleMovement('^', '0')<CR>

" How about ; and ,
nnoremap <silent> ; :call ToggleMovement(';', ',')<CR>
nnoremap <silent> , :call ToggleMovement(',', ';')<CR>

" How about H and L
nnoremap <silent> H :call ToggleMovement('H', 'L')<CR>
nnoremap <silent> L :call ToggleMovement('L', 'H')<CR>

" How about G and gg
" nnoremap <silent> G :call ToggleMovement('G', 'gg')<CR>
" nnoremap <silent> gg :call ToggleMovement('gg', 'G')<CR>

" Copy until eol
nnoremap Y yg_

" Keeping Cursor centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Highlight until eol
nnoremap V vg_
nnoremap vv V

" enable syntax related features
syntax enable

" searches are case insensitive if no upper word are in the search word
set ignorecase
" searches get case sensitive if any upper letter is in the search word
set smartcase


" This unsets the 'last search pattern' register by hitting return
" https://stackoverflow.com/a/662914
nnoremap <CR> :noh<CR><CR>

