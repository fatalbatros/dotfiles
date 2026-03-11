#!/bin/sh

xset r rate 400 50
setxkbmap -option caps:swapescape
xsetroot -solid "#080808"

while true; do
    stat=" "
    [[ $(cat /proc/meminfo) =~ MemAvailable:\ +([0-9]+)\ +kB ]]
    MEMORY=${BASH_REMATCH[1]}
    if [ $MEMORY -lt 2000000 ]; then 
        stat+='LOW_MEMORY '
    fi

    if [ -f /sys/class/net/wlan0/operstate ]; then 
        if [ "$(cat /sys/class/net/wlan0/operstate)" = "down" ]; then
            stat+='NO_SIGNAL '
        fi
    else
        stat+='NO_WIRELESS_DEVICE '
    fi

    BATERY=$(cat /sys/class/power_supply/BAT0/capacity)
    export BAT=$BATERY
    if [ $BATERY -lt 30 ]; then 
        stat+='LOW_BATERY '
    fi
#     stat+=$BATERY
    xsetroot -name "$stat"
    sleep 1m
done &
dwm
