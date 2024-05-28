#!/bin/bash

pacman_packages=(
    "bat"
    "docker"
    "docker-compose"
    "exa"
    "fd"
    "htop"
    "jq"
    "syncthing"
    "git-delta"
    "jless"
    "kitty"
    "keyd"
    "neovim"
    "nodejs"
    "npm"
    "ripgrep"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

sudo pacman -S --noconfirm "${pacman_packages[@]}"
