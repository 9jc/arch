#!/bin/bash
#Low Battery Warning Script

# Variables [ Commmands ]
CAP=`cat /sys/class/power_supply/BAT0/capacity`
BATTINFO=`acpi -b`
TIME=`acpi -b | cut -f 5 -d " "`

# Battery Full [ 95% ]
if [[ $CAP > 94 ]] ; then
    DISPLAY=:0.0 notify-send -i /usr/share/icons/gnome/32x32/status/battery-full-charged.png "Battery Full [Unplug the charger]"  "Percentage - $CAP% \nDischarging - Time Left $TIME"
    # mpv ~/.config/polybar/scripts/battery-charged.mp3 &
    exit 0
fi

# Battery Low [ 30% ]
if [[ `echo $BATTINFO | grep Discharging` && $CAP < 35 ]] ; then
    DISPLAY=:0.0 notify-send -i /usr/share/icons/gnome/32x32/status/battery-low.png "Battery Low [Plug in charger]"  "Percentage - $CAP% \nDischarging - Time Left $TIME"
    mpv ~/.config/polybar/scripts/battery-warning.mp3 &
    exit 0
fi

# Battery Very Low [ About to DIE ] - Calculated by time left
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:15:00 ]] ; then
    DISPLAY=:0.0 notify-send -i /usr/share/icons/gnome/32x32/status/battery-caution.png "Battery about to [ DIE ]"  "Percentage - $CAP% \nDischarging - Time Left $TIME"
    # mpv ~/.config/polybar/scripts/battery-warning.mp3 &
    exit 0
fi
