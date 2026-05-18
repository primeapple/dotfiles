#!/bin/bash
set -euo pipefail

LSQ_PATH="$HOME/go/bin/lsq"

notify() {
    local title="$1"
    local body="$2"

    if command -v notify-send &> /dev/null; then
        notify-send "$title" "$body"
        return $?
    fi

    if [[ "$(uname)" == "Darwin" ]]; then
        osascript -e "display notification \"$body\" with title \"$title\"" 2>/dev/null
        return $?
    fi
}

if [ ! -f "$LSQ_PATH" ]; then
    notify "$0" "lsq is not installed at $LSQ_PATH, aborting"
    exit 1
fi

WORK_TAG=""
case "$1" in
    collab) WORK_TAG=#work/collab
    ;;
    dev) WORK_TAG=#work/dev
    ;;
    know) WORK_TAG=#work/know
    ;;
    org) WORK_TAG=#work/org
    ;;
    quit) WORK_TAG=#work/quit
    ;;
    rand) WORK_TAG=#work/rand
    ;;
    *) notify "$0" "unclear command '$1', aborting"; exit 1
    ;;
esac

TIME=$(date +%H:%M)

$LSQ_PATH -a "$TIME $WORK_TAG"

notify "$0" "Switched to $WORK_TAG"
