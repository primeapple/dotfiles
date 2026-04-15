#!/bin/bash
set -euo pipefail

if ! command -v lsq > /dev/null; then
    notify-send "$0" "lsq is not installed, aborting"
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
    *) notify-send "$0" "unclear command '$1', aborting"; exit 1
    ;;
esac

TIME=$(date +%H:%M)

lsq -a "$TIME $WORK_TAG"

notify-send --expire-time=5000 "$0" "Switched to $WORK_TAG"
