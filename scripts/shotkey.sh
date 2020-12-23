#!/usr/bin/env bash

STATE_DIR=$HOME/.local/share/shotkey;
[[ ! -d "$STATE_DIR" ]] && mkdir $STATE_DIR;

MODE_FILE=$STATE_DIR/mode;

NORMAL_MODE="-";

get_mode() {
  local mode=$(cat $MODE_FILE);
  echo "${mode:-$NORMAL_MODE}";
}

save_mode() {
  local mode_label=$SHOTKEY_MODE_LABEL;
  echo "${mode_label:-$NORMAL_MODE}" > $MODE_FILE;
  update-dwmblock keymode;
}

case $1 in
  on-mode-change) save_mode ;;
  mode) get_mode ;;
  *) echo "no"; exit 1; ;;
esac

