#!/bin/bash

source "$HOME/scripts/modules/utils.sh";
source "$HOME/scripts/modules/rofi-menu.sh";

DIR="$HOME/scripts/fontawesome-menu";
FONTS_DIR="$DIR/icons";
SCRIPT_FILE="$DIR/fa-menu.sh";

get_fonts() { cat $FONTS_DIR/$1; }

show_menu() {
  local icon=$(get_fonts icons-list | open-menu -p "Emoji :: " | awk '{print $1}');
  if [[ ! -z "$icon" ]]; then
    copy_str "$icon";
    notify-send "Emoji ($icon) copied to clipboard";
  fi;
}

case "$1" in
  menu) show_menu ;;
esac

