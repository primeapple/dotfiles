if status --is-interactive
    function _expand_dot
        if commandline --search-field >/dev/null
            commandline --search-field --insert '.'
        else if string match --quiet --regex -- '^(\.\./)*\.\.$' "$(commandline --current-token)"
            commandline --insert '/..'
        else
            commandline --insert '.'
        end
    end

    bind --mode insert '.' _expand_dot
end
