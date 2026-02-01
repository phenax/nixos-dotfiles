#!/usr/bin/env sh

set -eu -o pipefail

dir=$(ls /run/media/imsohexy/ | fzf --prompt="Copy to: ")

rsync \
  --exclude=.stfolder \
  --exclude=.thumbnails \
  -ahvP \
  --delete \
  --modify-window=2 \
  ~/Downloads/music/ \
  "/run/media/imsohexy/$dir"

notify-send "Done copying music. Sort it maybe?"
