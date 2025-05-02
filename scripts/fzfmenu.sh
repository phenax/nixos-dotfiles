#!/usr/bin/env sh

# log_() { echo "$@" >> ~/dump/log; } 

set -e;

width_px=1000
height_lines=25
top_offset=0
font_width=7

fzfmenu() {
  local screen_width=$(xdotool getdisplaygeometry 2>/dev/null | cut -d' ' -f1)

  local win_width=$(($width_px / $font_width))
  local win_offset=$((($screen_width - $width_px) / 2))

  local fzf_args=$([ -z "$*" ] && echo "" || printf "'%s' " "$@")

  local stdin_pipe=$(mktemp -u /tmp/fzfmenu-input-XXXX)
  local stdout_pipe=$(mktemp -u /tmp/fzfmenu-output-XXXX)
  mkfifo "$stdin_pipe" "$stdout_pipe"

  trap "rm -f '$stdin_pipe' '$stdout_pipe'" EXIT

  cat >"$stdin_pipe" <&0 &
  cat "$stdout_pipe" &

  local cmd="fzf --height=100% $fzf_args <'$stdin_pipe' >'$stdout_pipe'"

  st \
    -i -g "=${win_width}x${height_lines}+${win_offset}+${top_offset}" \
    -e sh -c "$cmd" \
    >/dev/null 2>&1;

  wait;
}

fzfinput() {
  fzfmenu --print-query "$@" | tail -n 1;
}

cmd="$1";
case "$cmd" in
  select) shift 1; fzfmenu "$@" ;;
  input) shift 1;fzfinput "$@" ;;
  *) fzfmenu "$@" ;;
esac

