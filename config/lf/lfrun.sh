#!/usr/bin/env bash

export FIFO_UEBERZUG="/tmp/lf-ueberzug-${PPID}";
export LAST_IMAGE_F="/tmp/lf-ueberzug-${PPID}-last-img";

function cleanup {
  ~/scripts/image.sh clear;
	rm "$FIFO_UEBERZUG" 2>/dev/null
	pkill -P $$
}

mkfifo "$FIFO_UEBERZUG" 2&>/dev/null;
mkfifo "$LAST_IMAGE_F" 2&>/dev/null;

trap cleanup EXIT
tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash &

lf "$@";
