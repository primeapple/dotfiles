source ~/.profile

if status is-interactive
    # set keybindings to be vi + emacs
    set -g fish_key_bindings fish_hybrid_key_bindings

    # default is 50 iirc
    set -g fish_escape_delay_ms 10

    if command -v bookmarker >/dev/null
        bookmarker --init fish | source
    end
end

set --export BUN_INSTALL "$HOME/.bun"
set --export GOPATH "$HOME/go"

for path_to_add in ~/.local/share/JetBrains/Toolbox/scripts ~/bin ~/.local/bin $BUN_INSTALL/bin $GOPATH/bin
    if test -d $path_to_add
        fish_add_path -g $path_to_add
    end
end

set --export CARGO_ENV "$HOME/.cargo/env.fish"
for file_to_source in $CARGO_ENV
    if test -f $path_to_add
        source $file_to_source
    end
end
