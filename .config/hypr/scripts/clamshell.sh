#!/bin/bash
set -euo pipefail

if [[ "$(hyprctl monitors)" =~ [[:space:]]DP-[0-9]+ ]]; then
  if [[ $1 == "open" ]]; then
    hyprctl keyword monitor "eDP-1,3840x2400@60,320x1440,2"
  else
    hyprctl keyword monitor "eDP-1,disable"
  fi
fi
