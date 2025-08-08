#!/bin/bash
set -euo pipefail

if ! command -v lsq > /dev/null; then
    echo "lsq is not installed, aborting" 1>&2
    exit 1
fi

WORK_TAG=""
case "$1" in
    dev) WORK_TAG=#work/dev
    ;;
    idea) WORK_TAG=#work/idea
    ;;
    maintenance) WORK_TAG=#work/maintenance
    ;;
    org) WORK_TAG=#work/org
    ;;
    quit) WORK_TAG=#work/quit
    ;;
    support) WORK_TAG=#work/support
    ;;
    *) echo "unclear command '$1', aborting" 1>&2; exit 1
    ;;
esac

TIME=$(date +%H:%M)

lsq -a "$TIME $WORK_TAG"

notify-send --expire-time=5000 "Switched to $WORK_TAG"
