#!/bin/bash

pacman_packages=(
    "docker"
    "docker-compose"
    "gcc"
    "syncthing"
    "kitty"
    "keyd"
    "nodejs"
    "npm"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
