#!/usr/bin/env bash

host="192.168.0.10"
port=6543

run() { ssh "$host" -p $port -tt "$@"; }
run_x() { ssh -X "$host" -p $port; }

run_git() {
  local cmd="$1"; shift 1;
  case "$cmd" in
    ls) run ls -1 /fagit ;;
  esac;
}

run_cloud() {
  local cmd="$1"; shift 1;
  case "$cmd" in
    ls) run ls -la "~/storage/public/$1" ;;
  esac;
}

run_media() {
  local cmd="$1"; shift 1;
  case "$cmd" in
    play) run mpc play ;;
    pause) run mpc pause ;;
    play-pause) run mpc toggle ;;
  esac;
}

run_webui() {
  local cmd="$1"; shift 1;
  case "$cmd" in
    pihole)    ~/.bin/open "http://$host:9292/admin" ;;
    sync)      ~/.bin/open "http://$host:9191" ;;
  esac;
}

cmd="$1"; shift 1;
case "$cmd" in
  shell)    run bash ;;
  web)      run_webui "$@" ;;
  top)      run ytop ;;
  update)   run yay -Syyu ;;
  git)      run_git "$@" ;;
  media)    run_media "$@" ;;
  cloud)    run_cloud "$@" ;;
  run)      run "$@" ;;
  x)        run_x ;;
esac

