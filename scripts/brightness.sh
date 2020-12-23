#!/bin/bash

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

#~/scripts/statusbar/statusbar.sh update brightness;
update-dwmblock brightness;

