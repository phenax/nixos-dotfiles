#!/usr/bin/env bash

type="$1"; shift;

spawn() { setsid -f "$@" >/dev/null 2>&1; }

video() {
  spawn mpv \
    -keep-open \
    --player-operation-mode=pseudo-gui \
    --force-window=immediate \
    "$@";
}

image() { spawn feh -x -F --image-bg "#0f0c19" "$@"; }

__tts() {
  # https://huggingface.co/rhasspy/piper-voices/tree/main/en/en_US
  # local tts_model="en_US-ryan-high.onnx";
  local tts_model="en_US-lessac-medium.onnx";
  # local tts_model="en_US-bryce-medium.onnx";
  local tts_model_path="$HOME/.config/piper-models/$tts_model";
  [ -f "$tts_model_path" ] || (echo "Model not found" && exit 1);

  local tmp_file=$(mktemp /tmp/newsboat-piper-tts.XXX);
  notify-send -t 6000 'Loading tts...';
  piper --model "$tts_model_path" -f "$tmp_file" --sentence_silence 0.4;
  video "$tmp_file";
}
tts() { __tts >/dev/null 2>&1; }

browser() { spawn sensible-browser "$@"; }

torrent-dl() { ~/scripts/torrent.sh torrent "$1" >/dev/null 2>&1; }

torrent-stream() {
  notify-send -t 10000 'Starting stream player...';
  spawn peerflix "$1" --mpv -- -keep-open --force-window=immediate >/dev/null 2>&1;
}

case "$type" in
  copy) echo "$@" | xclip -selection clipboard ;;
  tts) tts ;;
  image) image "$@" ;;
  video|audio) video "$@" ;;
  torrent-dl) torrent-dl "$@" ;;
  torrent-stream) torrent-stream "$@" ;;
  *)
    case "$1" in
      https://*youtu.be/*|https://*youtube.com/v/*) video "$@" ;;
      https://*youtube.com/watch*) video "$@" ;;
      magnet:*) torrent-dl "$@" ;;
      https*.torrent) torrent-dl "$@" ;;
      *) browser "$@" ;;
    esac
  ;;
esac;
