#!/bin/bash

directory=~/pictures/wallpaper/
TIMEOUT_AFTER_SECONDS=50

for ((i=1; i<=TIMEOUT_AFTER_SECONDS; i++)); do
    if pgrep -x "hyprpaper" > /dev/null; then
        monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')
        if [ -d "$directory" ]; then
            random_background=$(find $directory -type f -name "*.png" | shuf -n 1)

            for monitor in $monitors ; do
                hyprctl hyprpaper wallpaper "$monitor, $random_background"
            done
        fi
        break
    else
        sleep 1
    fi
done
