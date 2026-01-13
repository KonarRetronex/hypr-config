#!/bin/bash
# Check if animations are currently on (1)
IS_ACTIVE=$(hyprctl getoption animations:enabled | grep "int: 1")

if [ -z "$IS_ACTIVE" ]; then
    # If not active, turn them ON
    hyprctl keyword animations:enabled 1
    notify-send "Hyprland" "Animations Enabled"
else
    # If active, turn them OFF
    hyprctl keyword animations:enabled 0
    notify-send "Hyprland" "Animations Disabled"
fi