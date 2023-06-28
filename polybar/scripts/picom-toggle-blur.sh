#!/bin/bash

# Color
green=#02fc34
red=#fc0202

# Gets Picom Status and outputs into polybar
picom_status() {
  if pgrep -x "picom" &> /dev/null ; then
    echo %{F"$green"}
  else
    echo %{F"$red"}
  fi
}

# Picom Blur Toggle
picom_toggle_blur() {
  if pgrep -x "picom" &> /dev/null 
  then
    killall picom
  else
    picom --blur-method kawase --blur-strength 6 -b &> /dev/null &
  fi
}

# Picom Transparent Toggle
picom_toggle_transparent() {
  if pgrep -x "picom" &> /dev/null 
  then
    killall picom &> /dev/null 
  else
    picom &> /dev/null &
  fi
}


# Main (User Input)
if [[ $1 = "--toggle-blur" ]]; then
  picom_toggle_blur
elif [[ $1 = "--toggle-transparent" ]]; then
  picom_toggle_transparent
elif [[ $1 = "--status" ]]; then
  picom_status
else
  printf "[!] Avaliable options \n --toggle-blur --toggle-transparent --status"
fi
