#!/bin/bash

# Function to check if the mic is currently muted
is_mic_muted() {
    wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"
}

# Toggle the mute status for the microphone source
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

# Visual Logic: Show 0% and muted icon if muted, else show 100%
if is_mic_muted; then
    VALUE=0
    ICON="microphone-sensitivity-muted-symbolic"
else
    VALUE=100
    ICON="microphone-sensitivity-high-symbolic"
fi

# Send the clean Fire Red notification
notify-send -h string:x-canonical-private-synchronous:mic \
            -h int:value:"$VALUE" \
            -i "$ICON" \
            "" "Mic: $VALUE%" -t 800