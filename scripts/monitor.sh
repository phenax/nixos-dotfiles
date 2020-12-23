#!/bin/bash

source "$HOME/scripts/modules/rofi-menu.sh";

PRIMARY="eDP1";

list-monitors() { xrandr --listmonitors | grep -v 'Monitors:' | awk '{print $4 " (" $3 ")"}'; }

monitor-off() { xrandr --output ${1:-"HDMI-1"} --off; };

monitor-on() {
  xrandr --output ${2:-"HDMI-1"} --auto --${1:-"right-of"} $PRIMARY;
}

show-menu() {
  list-monitors | open-menu -p "Monitors";
}

case $1 in
  ls) list-monitors ;;
  on) monitor-on "$2" "$3" ;;
  off) monitor-off "$2" ;;
  menu) show-menu ;;
  *) echo "Fuck off" ;;
esac;

