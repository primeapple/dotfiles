#!/bin/bash

brew_packages=(
    "docker"
    "gnupg"
    "go"
    "opencode"
    "syncthing"
    "tree-sitter-cli"
    "unzip"
    "zip"
)

brew_cask_packages=(
    "font-jetbrains-mono-nerd-font"
)

brew install --quiet "${brew_packages[@]}"
brew install --quiet --cask "${brew_packages[@]}"
