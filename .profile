# my own stuff
export EDITOR=nvim
export VISUAL=nvim

# for sway
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export WLR_NO_HARDWARE_CURSORS=1
#export WLR_NO_HARDWARE_CURSORS=0
export WLR_RENDERER_ALLOW_SOFTWARE=1

export _JAVA_AWT_WM_NONREPARENTING=1
# export WAYLAND_DISPLAY=wayland-1

# for GnuPG
export GPG_TTY=$(tty)

export GTK_USE_PORTAL=0

# for fzf
export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --multi --preview "bat --color=always --style=header,grid --line-range :500 {}"'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .cache --exclude .gradle'
