#!/bin/bash

brew_packages=(
    "coreutils"
    "docker"
    "gh"
    "gh"
    "gnupg"
    "gnu-sed"
    "lua"
    "python"
    "syncthing"
    "tree-sitter-cli"
    "unzip"
    "zf"
    "zip"
)

brew_cask_packages=(
    "font-jetbrains-mono-nerd-font"
)

brew install --quiet "${brew_packages[@]}"
brew install --quiet --cask "${brew_cask_packages[@]}"
