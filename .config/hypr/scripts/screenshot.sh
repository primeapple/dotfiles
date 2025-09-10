#!/bin/bash
set -euo pipefail

mkdir -p "${HOME}/pictures/screenshots"

FILE_NAME=""
FILE_PATH=""
case "$1" in
    full)
        FILE_NAME="screenshot-$(date +%F-%T)-full.png"
        FILE_PATH="${HOME}/pictures/screenshots/${FILE_NAME}"
        grim -t png "${FILE_PATH}"
        ;;
    selection)
        FILE_NAME="screenshot-$(date +%F-%T)-selection.png"
        FILE_PATH="${HOME}/pictures/screenshots/${FILE_NAME}"
        grim -t png -g "$(slurp)" "${FILE_PATH}"
        ;;
    *) notify-send "$0" "unclear command '$1', aborting"; exit 1
        ;;
esac

notify-send 'Screenshot' -i "${FILE_PATH}" "${FILE_NAME}"
