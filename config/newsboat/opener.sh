#!/usr/bin/env bash

type="$1"; shift;

video() { mpv --player-operation-mode=pseudo-gui "$@"; }
image() { feh -x -F --image-bg "#0f0c19" "$@"; }

case "$type" in
  image) image "$@" ;;
  video|audio) video "$@" ;;
  *)
    case "$1" in
      https://*youtube.com/watch*) video "$@" ;;
      https://youtu.be/*) video "$@" ;;
      *) sensible-browser "$@" 2>&1 >/dev/null & disown ;;
    esac
  ;;
esac;
