#!/usr/bin/env bash

dir="$1";

editor="sensible-editor";

if [[ -f "$dir/default.nix" ]]; then
  editor="nix-shell --run '$editor'";
fi;

term() { sensible-terminal -d "$dir" "$@"; }
editor() { term -e sh -c "echo 'Loading...'; $editor; zsh"; }

editor &
sleep 0.1;
term &
term &

disown;

