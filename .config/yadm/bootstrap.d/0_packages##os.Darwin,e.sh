#!/bin/bash

brew_packages=(
    "docker"
    "tree-sitter"
    "unzip"
    "zip"
)

brew install --quiet "${brew_packages[@]}"
