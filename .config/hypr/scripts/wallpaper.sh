#!/bin/bash

directory=~/pictures/wallpaper/
monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')

if [ -d "$directory" ]; then
    random_background=$(find $directory -type f -name "*.png" | shuf -n 1)

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$random_background"
    for monitor in $monitors ; do
        hyprctl hyprpaper wallpaper "$monitor, $random_background"
    done
fi
