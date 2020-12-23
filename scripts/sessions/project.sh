#!/usr/bin/env bash

dir="$1";

sensible-terminal -d "$dir" -e sensible-editor . &
sleep 0.1;
sensible-terminal -d "$dir" &
sensible-terminal -d "$dir" &

disown;

