#!/bin/bash

# Define the options
options="  Power Off\n  Reboot\n  Suspend\n  Log Out\n  Lock Screen\n  Apps"

# Show the menu using Rofi
chosen="$(echo -e "$options" | rofi -dmenu -p "System" -config ~/.config/rofi/config.rasi)"

# Execute the chosen action
case $chosen in
    *"Power Off") systemctl poweroff ;;
    *"Reboot") systemctl reboot ;;
    *"Suspend") sleep 1 && systemctl suspend ;;
    *"Log Out") hyprctl dispatch exit ;;
    *"Lock Screen") hyprlock ;;
    *"Apps") rofi -show drun ;;
esac