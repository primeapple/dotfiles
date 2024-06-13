source ~/.profile

if status is-interactive
    # Commands to run in interactive sessions can go here

    # set keybindings to be vi + emacs
    set -g fish_key_bindings fish_hybrid_key_bindings

    # default is 50 iirc
    set -g fish_escape_delay_ms 10

    for path_to_add in ~/.local/share/JetBrains/Toolbox/scripts ~/bin
        if test -d $path_to_add
            fish_add_path -g $path_to_add
        end
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
