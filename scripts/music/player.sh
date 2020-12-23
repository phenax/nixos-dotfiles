#!/bin/bash

player() { playerctl --player=mopidy "$@"; }

# Get player state
#get_play_state() { player metadata --format '{{status}}' || echo 'Stopped'; }
get_play_state() {
  local state=$(mpc status | awk '/\[\w*\]/ {print $1}');
  case "$state" in
    '[playing]') echo "Playing" ;;
    '[paused]') echo "Paused" ;;
    *) echo "Stopped" ;;
  esac;
}

# Get title - artist (song label)
#get_label() { player metadata --format '{{title}} - {{artist}}' || echo '...'; }
get_label() {
  echo -n "$(mpc current | cut -c1-20)";
  echo "...";
}

# Play/Pause toggle:
play_pause() {
  #player play-pause;
  mpc toggle;
  update-dwmblock music;
}

# Next/Prev
next() {
  #player next;
  mpc next;
  update-dwmblock music;
}
prev() {
  #player previous;
  mpc prev;
  update-dwmblock music;
}

notify() {
  update-dwmblock music;
}

case "$1" in
  play_pause|pp) play_pause ;;
  next|n) next ;;
  prev|p) prev ;;
  dump_metadata) get_metadata ;;
  get_label) get_label ;;
  get_play_state) get_play_state ;;
  notify) notify ;;
  *) echo "Learn how to use shit before you use them" ;;
esac

