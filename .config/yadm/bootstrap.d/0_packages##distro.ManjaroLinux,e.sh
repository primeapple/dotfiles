#!/bin/bash

# lazydocker, ctop, yay, neovim?,
pacman_shell_packages=(
    "zip"
    "unzip"
	"bat"
    "delta-git"
	"docker"
	"docker-compose"
	"exa"
	"fd"
	"htop"
	"jq"
    "jless"
	"keepassxc"
	"syncthing"
	"youtube-dl"
    "node"
    "npm"
    "ripgrep"
)

# vscode
pacman_gui_packages=(
	"chromium"
	"firefox"
	"kitty"
	"thunderbird"
)

# jetbrains toolbox
aur_packages=(
	"stretchly"	
)


## Installing pacman packages ##
# pacman -S "${pacman_packages[@]}"
# which "${pacman_packages[@]}"
