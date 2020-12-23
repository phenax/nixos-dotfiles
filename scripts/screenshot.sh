#!/usr/bin/env bash

SCREENSHOTS=$HOME/Pictures/screenshots;

notify() { notify-send "$@"; }

scrsht() {
  local type=$1;
  local window=$([ -z "$2" ] && echo "" || echo "-window $2");
  magick import $window "$SCREENSHOTS/$type-$(date '+%Y_%m_%d_%H_%M_%S').jpg";
  notify "Screenshot ($type) captured";
}

full_screenshot() { scrsht full root; }
part_screenshot() { sleep 0.2; scrsht part & disown; }
window_screenshot() { scrsht window "${1:-"$(xdo id)"}"; }

case $1 in
  full) full_screenshot ;;
  part) part_screenshot ;;
  window) window_screenshot "$2" ;;
  *) echo "no"; exit 1 ;;
esac

