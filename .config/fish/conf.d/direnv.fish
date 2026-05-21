if status --is-interactive
    if command -v direnv >/dev/null
        direnv hook fish | source
        set -g direnv_fish_mode disable_arrow
    end
end
