#!/bin/bash

#put this file anywere. Recomendation /usr/local/bin/, make it executable
DEVICE=$(grep -A4 "Bose NC 700 Headphones" /proc/bus/input/devices \
    | grep -m1 -o 'event[0-9]*' \
    | sed 's;^;/dev/input/;')

if [ -z "$DEVICE" ]; then
    exit 1
fi

/usr/bin/evtest "$DEVICE" | while read -r line; do
    case "$line" in
        *KEY_PLAYCD*value\ 1*)
            STATE=$(runuser -u alba -- /usr/bin/mpc status %state%)
            if [ "$STATE" = "stopped" ]; then
                runuser -u alba -- /usr/bin/rmpc addrandom "album" 1
                runuser -u alba -- /usr/bin/mpc toggle
            else
                runuser -u alba -- /usr/bin/mpc toggle
            fi
            ;;
        *KEY_NEXTSONG*value\ 1*)
            runuser -u alba -- /usr/bin/mpc next
            ;;
        *KEY_PREVIOUSSONG*value\ 1*)
            STATE=$(runuser -u alba -- /usr/bin/mpc status %state%)
            if [ "$STATE" = "stopped" ]; then
                runuser -u alba -- /usr/bin/shutdown now
            elif [ "$STATE" = "paused" ]; then
                runuser -u alba -- /usr/bin/mpc clear
            else
                runuser -u alba -- /usr/bin/mpc prev
            fi
            ;;
    esac
done

#If the headset disconect, I dont want the music to keep playing in the speakers
runuser -u alba -- /usr/bin/mpc pause
