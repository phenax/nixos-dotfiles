#!/usr/bin/env bash

mic_keep_on() {
  while true; do
    local audio_state=$(amixer get Capture | awk "/: Capture.*\[/ {print \$7}" | head -n 1);
    [[ "$audio_state" != "[on]" ]] && amixer set Capture cap;
    sleep 1;
  done;
}

case "$1" in
  mute-mic) amixer set Capture toggle ;;
  mic-keep-on) mic_keep_on ;;
  mic-vol) case "$2" in
    up) amixer sset 'Mic Boost' '1%+' && amixer sset 'Internal Mic Boost' '1%+' ;;
    down) amixer sset 'Mic Boost' '1%-' && amixer sset 'Internal Mic Boost' '1%-' ;;
    full) amixer sset 'Mic Boost' '100%' && amixer sset 'Internal Mic Boost' '100%' ;;
  esac ;;

  mute) amixer set Master toggle ;;
  volume) case "$2" in
    up) amixer sset Master '5%+' ;;
    down) amixer sset Master '5%-' ;;
  esac ;;
  *) echo "Wrong command" ;;
esac

#~/scripts/statusbar/statusbar.sh update volume;
update-dwmblock volume;
