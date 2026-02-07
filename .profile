### Basics
export EDITOR=nvim
export VISUAL=nvim

### GnuPG
export GPG_TTY=$(tty)

### Language specifics
export GOPATH=$HOME/go
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

### OTHER
export GTK_USE_PORTAL=0

### PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
