# for GTK Apps to lauch without delay
for f in /etc/X11/xinit/xinitrc.d/*.sh; do
  source "$f"
done

# Wallpaper Restore
nitrogen --restore &

dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &

xrdb -merge ~/.Xresources &
#lxappearance &
nm-applet &
pamac-tray &
/usr/bin/dunst &

# Auto suspend when not online [ paru -Sy --noconfirm --needed xidlehook ]
# 300s - 5m / 900s - 15m / 1800s - 30m / 3600s - 1h / 86400s -24h
xidlehook --not-when-audio --not-when-fullscreen --timer 600 'feh $HOME/Pictures/Blackwall/black-solid & systemctl suspend' 'betterlockscreen -l --text "Error 404:Desktop Crashed"'  &  

#gestures app 
libinput-gestures-setup start &
xsetroot -Volantes_Light_Curser left_ptr & 
/* xsetroot -cursor_name left_ptr & */

# Normal Applications
#xfce4-clipman &
xdman &
conky &
megasync &
aw-qt &
copyq &
ulauncher  --no-window-shadow --hide-window &
sxhkd &
redshift &
safeeyes &
todoist &
cpupower-gui -b &
blueman-applet &
kill all mpd
mpd --no-daemon --stdout --verbose &

# battery-monitor & # https://github.com/maateen/battery-monitor

# Window Managers
exec bspwm

