#!/usr/bin/env bash

outfile=${1:-"$HOME/Pictures/recordings/video-webcam-$(date -Iminutes).mp4"};

[[ -f "$outfile" ]] && echo "[File already exists]: $outfile" && exit 1;

# ffmpeg -i /dev/video0 out.mkv
ffmpeg -i /dev/video0 -f alsa -i default $outfile;
