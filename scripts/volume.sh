#!/bin/bash

# Function to get current volume level
get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'
}

# Function to check if the system is currently muted
is_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
}

case $1 in
    up)
        # Automatically unmute when raising volume for better UX
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

# Visual Logic: If muted, force the display to show 0% and a muted icon
if is_muted; then
    VOLUME=0
    ICON="audio-volume-muted"
else
    VOLUME=$(get_volume)
    ICON="audio-volume-high"
fi

# Send the clean Fire Red notification
notify-send -h string:x-canonical-private-synchronous:volume \
            -h int:value:"$VOLUME" \
            -i "$ICON" \
            "" "$VOLUME%" -t 800