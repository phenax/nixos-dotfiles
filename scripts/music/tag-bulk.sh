#!/usr/bin/env bash

artist=$1;
album=$2;

ext=${3:-'opus'};

file=${4:-'taginfo'};

total=$(cat $file | wc -l);

cat $file | while read n song; do
  song_file="$song.$ext";
  if [[ -f "$song_file" ]]; then
    ~/scripts/music/tag.sh \
      -a "$artist" \
      -A "$album" \
      -t "$song" \
      -n "$n" \
      -N "$total" \
      "$song_file";
  else 
    echo "File $song_file not found";
  fi;
done;

