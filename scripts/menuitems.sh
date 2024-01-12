#!/usr/bin/env bash

volume_component() { amixer get Master | awk -F'[][]' '/Left:/ {print $C}' C="$1"; }
mic_component() { amixer get Capture | awk -F'[][]' '/dB/ {print $C}' C="$1" | head -n 1; }

playerctl_icon() {
  local playstate="$(~/scripts/music/player.sh get_play_state)";
  case "$playstate" in
    Paused) echo "" ;;
    Playing) echo "" ;;
    Stopped) echo "" ;;
    *) ;;
  esac
}

network_state() {
  local status=$((nmcli dev show wlp0s20f3 || echo "") | grep '^GENERAL.STATE:' | sed 's/^GENERAL.STATE:\s*//g');
  echo "  ${status:0:16}"; 
}

volume_icon() { volume_component 4 | sed 's/on//; s/off/🔇/'; }
mic_icon() { mic_component 4 | sed 's/on//; s/off/✖/'; }

icon() {
  case "$1" in
    date)        echo "" ;;
    battery)     echo "" ;;
    music)       playerctl_icon ;;
    volume)      volume_icon ;;
    brightness)  echo "" ;;
    network)     network_state ;; # | sed 's/\(connected\)//; s/\(connecting.*\)//; s/\(disconnected\)/❌/' ;;
    *) ;;
  esac
}

date_module() {
  echo "$(icon date)  $(date +"%A, %e %b - %I:%M %p")";
}

battery_module() {
  local capacity=$(cat "/sys/class/power_supply/BAT0/capacity");
  echo "$(icon battery)  $capacity%";
}

music_module() {
  local label=$(~/scripts/music/player.sh get_label);
  echo "$(icon music)  $label";
}

brightness_module() {
  echo "$(icon brightness)  $(printf "%.0f%s" "$(xbacklight -get)" "%")"
}

volume_module() {
  echo "$(icon volume)  $(volume_component 2)";
}

keymode_module() {
  echo "$(~/scripts/shotkey.sh mode)";
}

network_module() {
  echo "$(icon network)";
}


get_module() {
  case "$1" in
    date) date_module ;;
    battery) battery_module ;;
    volume) volume_module ;;
    music) music_module ;;
    brightness) brightness_module ;;
    keymode) keymode_module ;;
    network) network_module ;;
  esac;
}

padding="  ";

echo "$padding$(get_module $1 || echo "-")$padding";
exit 0;
