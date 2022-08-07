#!/usr/bin/env bash

source "$HOME/scripts/modules/rofi-menu.sh";

PRIMARY="eDP1";

list-monitors() { xrandr --listmonitors | grep -v 'Monitors:' | awk '{print $4 " (" $3 ")"}'; }

monitor-off() { xrandr --output ${1:-"HDMI1"} --off; };

monitor-on() {
  xrandr --output ${2:-"HDMI1"} --auto --${1:-"right-of"} $PRIMARY;
}

show-menu() {
  list-monitors | open-menu -p "Monitors";
}

case $1 in
  ls) list-monitors ;;
  on) monitor-on "$2" "$3" ;;
  sidekick)
    xrandr --output ${3:-"HDMI1"} --auto --${2:-"left-of"} $PRIMARY --rotate right --brightness 1.5
  ;;
  off) monitor-off "$2" ;;
  menu) show-menu ;;
  *) echo "Fuck off" ;;
esac;

