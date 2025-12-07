#!/bin/bash

pacman_packages=(
    "docker"
    "docker-compose"
    "gcc"
    "keyd"
    "kitty"
    "nodejs"
    "npm"
    "syncthing"
    "tree-sitter-cli"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
