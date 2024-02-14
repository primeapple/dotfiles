# my own stuff
export EDITOR=nvim
export VISUAL=nvim

# for GnuPG
export GPG_TTY=$(tty)

export GTK_USE_PORTAL=0

# for fzf
export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --multi --preview "bat --color=always --style=header,grid --line-range :500 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .cache --exclude .gradle'
