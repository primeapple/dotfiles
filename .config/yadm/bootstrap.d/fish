#!/bin/bash

# setting default shell to fish, if it isn't yet
# if [ $(basename "$SHELL") != "fish" ]; then
#     echo "Setting default shell to fish"
#     chsh -s $(which fish)
# fi


# adding .bin folder to path
fish -c "
if not contains ~/.bin \$PATH
	fish_add_path ~/.bin
end
"

# adding nice fish greeting
fish -c "set -U fish_greeting 'Welcome to fish 🐟'"
fish -c "set -U fish_features qmark-noglob"
fish -c "echo y | fish_config theme save kanagawa"

# manage fisher plugins, this should normally work through the fish_plugins file, but sadly does not work yet
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install jethrokuan/z"
fish -c "fisher install jorgebucaran/autopair.fish"
fish -c "fisher install jorgebucaran/nvm.fish"
fish -c "fisher install jorgebucaran/replay.fish"
fish -c "fisher install nickeb96/puffer-fish"
fish -c "fisher install lilyball/nix-env.fish"
fish -c "fisher install IlanCosman/tide@v6"
fish -c "tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Few icons' --transient=No"
