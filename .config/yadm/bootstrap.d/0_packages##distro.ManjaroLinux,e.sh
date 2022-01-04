#!/bin/bash

# TODO: lazydocker, ctop, yay
pacman_packages=(
	"bat"
	"exa"
	"fd"
	"htop"
	"jq"
	"tmux"
)

aur_packages=(
	"stretchly"	
)


## Installing pacman packages ##
#pacman -S "${pacman_packages[@]}"
which "${pacman_packages[@]}"
