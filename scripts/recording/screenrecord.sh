#!/usr/bin/env bash

prefix=${2:-"video"};

outfile=${1:-"$HOME/Pictures/recordings/$prefix-screen-$(date -Iminutes).mp4"};

ffmpeg -f x11grab -s 1920x1080 -i :0.0 -f alsa -i hw:0,0 $outfile;
