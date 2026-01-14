#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
NAME="Screenshot_$(date +%Y%m%d_%H%M%S).png"

# Ensure directory exists
mkdir -p "$DIR"

case $1 in
    "active")
        # Get position and size of the ACTIVE window instantly
        GEOMETRY=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOMETRY" "$DIR/$NAME"
        ;;
    "screen")
        # Capture the currently FOCUSED monitor instantly
        MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
        grim -o "$MONITOR" "$DIR/$NAME"
        ;;
esac

# Copy to clipboard (requires wl-copy)
wl-copy < "$DIR/$NAME"

# Notify
notify-send "Screenshot Saved" "File: $NAME"