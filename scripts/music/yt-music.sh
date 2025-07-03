#!/usr/bin/env sh

set -e -o pipefail

MUSIC_DIR="$HOME/Downloads/music"

yt_download() {
  local url="$1"

  if [ -z "$url" ]; then
    url=$(echo -n "" | dmenu -p "YT music URL :: ")
  fi

  if [ -z "$url" ]; then
    echo "Nothing to download";
    exit 1;
  fi

  if is_downloaded "$url" && [ ! "$FORCE" == "1" ]; then
    echo "== already downloaded =="
    return 0;
  fi

  yt-dlp -x --audio-format mp3 \
    --embed-metadata --embed-thumbnail \
    --parse-metadata "playlist_index:%(track_number)s" --add-metadata \
    -o "$MUSIC_DIR/%(artist|Others)s/%(album,playlist)s/%(playlist_index)02d - %(title)s.%(ext)s" \
    "$url" \
    && mark_as_done "$url"
}

is_downloaded() { grep "$1" "$MUSIC_DIR/music.lock" > /dev/null 1>&2; }

mark_as_done() {
  echo "$1" >> "$MUSIC_DIR/music.lock"
  sort -u "$MUSIC_DIR/music.lock" -o "$MUSIC_DIR/music.lock"
}

library_data() { jq -r "$1" "$MUSIC_DIR/music.json"; }

sync_library() {
  library_data ".[].url" | while read url; do
    yt_download "$url" || notify-send -u critical "Sync failed for $url"
  done
}

cmd="$1"; shift 1;
case "$cmd" in
  yt)
    yt_download "$@" \
      && notify-send "Music downloaded" \
      || notify-send -u critical "Music download failed"
  ;;
  sync)
    sync_library && notify-send "Sync done"
  ;;
  *) echo "invalid cmd. (yt | sync)"; exit 1 ;;
esac

