#!/bin/bash

# Change brightness based on argument
case $1 in
    up)
        brightnessctl set 5%+
        ;;
    down)
        brightnessctl set 5%-
        ;;
esac

# Get the current percentage
VALUE=$(brightnessctl info | grep -oP '\(\K[^%]+(?=%\))')

# Send the clean Fire Red notification
notify-send -h string:x-canonical-private-synchronous:brightness \
            -h int:value:"$VALUE" \
            -i "display-brightness-symbolic" \
            "" "$VALUE%" -t 800