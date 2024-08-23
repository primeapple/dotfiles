#!/bin/bash
set -euo pipefail

open() {
    hyprctl keyword monitor "eDP-1,3840x2400@60,320x1440,2"
}

close() {
    hyprctl keyword monitor "eDP-1,disable"
}

toggle() {
    if [[ "$(hyprctl monitors)" =~ eDP-[0-9]+ ]]; then
        close
    else
        open
    fi
}


main() {
    if ! [[ "$(hyprctl monitors)" =~ [[:space:]]DP-[0-9]+ ]]; then
        echo "No second monitor found, aborting"
        exit 0
    fi

    local usage="Usage: $0 {open|close|toggle}"
    
    if [ $# -ge 1 ]; then
        case "$1" in
            open)
                open
                ;;
            close)
                close
                ;;
            toggle)
                toggle
                ;;
            *)
                echo "$usage"
                exit 1
                ;;
        esac
    else
        echo "$usage"
        exit 1
    fi
}

main "$@"
