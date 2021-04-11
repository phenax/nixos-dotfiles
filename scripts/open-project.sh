#!/usr/bin/env bash

PROJECTS_DIR="$HOME/dev/projects";
SUCKLESS_DIR="$HOME/.config/suckless";

get_projects() {
  ls -t "$PROJECTS_DIR" | sed 's/^/dev:/g';
  ls -t "$SUCKLESS_DIR" | sed 's/^/suckless:/g';
}

project=$(get_projects | dmenu -p "Project name :: ");

if [ -z "$project" ]; then
  exit 1;
fi;

projtype=$(echo "$project" | cut -d: -f1);
projdir=$(echo "$project" | cut -d: -f2-);

fulldir="";

case "$projtype" in
  dev)        fulldir="$PROJECTS_DIR/$projdir" ;;
  suckless)   fulldir="$SUCKLESS_DIR/$projdir" ;;
  *)          fulldir="$PROJECTS_DIR/$projdir" ;;
esac

if [ ! -z "$fulldir" ]; then
  if [ ! -d "$fulldir" ]; then
    mkdir -p $fulldir;
    notify-send "Created new project at $fulldir";
  fi;

  ~/scripts/sessions/project.sh "$fulldir";
fi;

