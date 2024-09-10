#!/usr/bin/env bash

type="$1"; shift;

video() {
  mpv \
    --player-operation-mode=pseudo-gui \
    --force-window=immediate \
    "$@" >/dev/null 2>&1 & disown;
}
image() { feh -x -F --image-bg "#0f0c19" "$@" >/dev/null 2>&1 & disown; }

browser() { sensible-browser "$@" >/dev/null 2>&1 & disown; }

case "$type" in
  copy) echo "$@" | xclip -selection clipboard ;;
  image) image "$@" ;;
  video|audio) video "$@" ;;
  *)
    case "$1" in
      https://*youtu.be/*|https://*youtube.com/v/*) video "$@" ;;
      https://*youtube.com/watch*) video "$@" ;;
      *) browser ;;
    esac
  ;;
esac;
