#!/bin/bash

pacman_packages=(
    "bat"
    "docker"
    "docker-compose"
    "exa"
    "fd"
    "htop"
    "jq"
    "keepassxc"
    "syncthing"
    "git-delta"
    "jless"
    "kitty"
    "neovim"
    "nodejs"
    "npm"
    "ripgrep"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

pacman -S "${pacman_packages[@]}"
