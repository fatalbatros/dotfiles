#!/bin/sh

xset r rate 400 50
setxkbmap -option caps:swapescape
xsetroot -solid "#080808"
xinput set-prop "pointer:Logitech M280/320/275" "libinput Accel Profile Enabled" 0, 1
xinput set-prop "pointer:Logitech M280/320/275" "libinput Accel Speed" 0.3


while true; do
    stat=" "
    [[ $(cat /proc/meminfo) =~ MemAvailable:\ +([0-9]+)\ +kB ]]
    MEMORY=${BASH_REMATCH[1]}
    if [ $MEMORY -lt 2000000 ]; then 
        stat+='LOW_MEMORY '
    fi
    
    stat+=$(date +%_H:%M)
    xsetroot -name "$stat"
    sleep 1m
done &
dwm
