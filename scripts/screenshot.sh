#!/usr/bin/env bash

SCREENSHOTS=$HOME/Pictures/screenshots;

notify() { notify-send "Screenshot captured. $@"; }

file_name() {
  echo "$SCREENSHOTS/$1-$(date '+%Y_%m_%d_%H_%M_%S').jpg"
}

full_screenshot() {
  import -window root "$(file_name full)"
  notify "(full)"
}
part_screenshot() {
  sleep 0.2;
  import "$(file_name part)"
  notify "(selection)"
}
window_screenshot() {
  local wid="${1:-"$(xdotool getwindowfocus)"}"
  echo "WID: $wid"
  import -window "$wid" "$(file_name window)"
  notify "(window)"
}

case $1 in
  full) full_screenshot ;;
  part) part_screenshot ;;
  window) window_screenshot "$2" ;;
  monitor) full_screenshot -display "$1" ;;
  *) echo "no"; exit 1 ;;
esac

