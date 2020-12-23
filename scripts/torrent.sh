#!/usr/bin/env bash

source "$HOME/scripts/modules/utils.sh";

DOWNLOAD_LOCATION=$HOME/Downloads/dl;

is_magnet() { echo "$1" | grep '^magnet:'; }

add_magnet_link() {
  is_magnet "$1" && \
    transmission-remote -a "$1" && \
    notify-send "Torrent" "Added torrent for downloading";
}

add_from_clipboard() {
  add_torrent "$(read_clipboard)";
}

add_torrent() {
  transmission-remote -a "$1" && \
    notify-send "Torrent" "Added torrent for downloading";
  #local name=$(btinfo "$1" | awk -F': ' '/Name:/ {print $2}');
  #btcli add -d "$DOWNLOAD_LOCATION/$name" "$1";
}

case "$1" in
  add) add_magnet_link "$2" ;;
  magnet) add_magnet_link "$2" ;;
  torrent) add_torrent "$2" ;;
  add_from_clipboard) add_from_clipboard ;;
esac;

