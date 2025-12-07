#!/bin/bash

apt_packages=(
    "fish"
    "tree-sitter-cli"
)

sudo apt install --assume-yes "${apt_packages[@]}"
