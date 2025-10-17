#!/bin/bash
set -euo pipefail

if ! command -v lsq > /dev/null; then
    notify-send "$0" "lsq is not installed, aborting"
    exit 1
fi

WORK_TAG=""
case "$1" in
    bug) WORK_TAG=#work/bug
    ;;
    feat) WORK_TAG=#work/feat
    ;;
    incident) WORK_TAG=#work/incident
    ;;
    know) WORK_TAG=#work/know
    ;;
    maintenance) WORK_TAG=#work/maintenance
    ;;
    org) WORK_TAG=#work/org
    ;;
    quit) WORK_TAG=#work/quit
    ;;
    support) WORK_TAG=#work/support
    ;;
    technical) WORK_TAG=#work/technical
    ;;
    *) notify-send "$0" "unclear command '$1', aborting"; exit 1
    ;;
esac

TIME=$(date +%H:%M)

lsq -a "$TIME $WORK_TAG"

notify-send --expire-time=5000 "$0" "Switched to $WORK_TAG"
