#!/bin/bash

pacman_packages=(
    "docker"
    "docker-compose"
    "syncthing"
    "kitty"
    "keyd"
    "nodejs"
    "npm"
    "trash-cli"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
