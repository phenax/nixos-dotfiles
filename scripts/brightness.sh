#!/usr/bin/env bash

max() { [[ "$1" -gt "$2" ]] && echo "$1" || echo "$2"; }
min() { [[ "$1" -lt "$2" ]] && echo "$1" || echo "$2"; }
between() { max "$2" $(min "$1" "$3"); }

adapter_bctl() {
  set_() { brightnessctl set "$@"; }
  get() { brightnessctl get; }
  max_b() { brightnessctl m; }
  update() {
    local curr=`brightnessctl get`;
    local min=100;
    local max=`max_b`;
    set_ $(between $(echo "$curr $1" | bc) $min $max);
  }

  local delta="1000";
  case "$1" in
    get) echo "100 * `get` / `max_b`" | bc ;;
    set) set_ $(echo "$2 * `max_b` / 100" | bc) ;;
    inc) update "+ $delta" ;;
    dec) update "- $delta" ;;
    *) echo "invalid command" ;;
  esac;
}

adapter_xbacklight() {
  read_brightness() { xbacklight -get; }

  get_brightness() { printf "%.0f%s" "$(read_brightness)" "%"; }

  set_brightness() { xbacklight -set $1; }

  increment() { xbacklight -inc $1; }
  decrement() { xbacklight -dec $1; }

  case $1 in
    get) get_brightness ;;
    set) set_brightness $2 ;;
    inc) increment $2 ;;
    dec) decrement $2 ;;
    *) echo "For tools to work, you need to know how to use them" ;;
  esac
}

adapter_bctl "$@";
update-dwmblock brightness;

