#!/usr/bin/env bash

outfile=${1:-"$HOME/Pictures/recordings/video-cs-$(date -Iminutes).mp4"};

[[ -f "$outfile" ]] && echo "[File already exists]: $outfile" && exit 1;

ffplay /dev/video0 -s 300x200 -an &

ffmpeg -f x11grab -s 1920x1080 -i :0.0 -f alsa -i hw:0,0 $outfile;

