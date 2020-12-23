#!/usr/bin/env bash

MUSIC_DIR="$HOME/Downloads/music";
EXT=opus;

AUDIO_FILE="$1";
TIMESTAMPS_FILE="$2";

ALBUM_ARTIST=$(echo "$TIMESTAMPS_FILE" | sed -e 's/^.*\///g' -e 's/\.splits$//');

ARTIST="$(echo $ALBUM_ARTIST | awk -F' - ' '{print $1}')";
ALBUM="$(echo $ALBUM_ARTIST | awk -F' - ' '{print $2}')";

OUT_DIR="$MUSIC_DIR/$ARTIST/$ALBUM";
[[ ! -d "$OUT_DIR" ]] && mkdir -p "$OUT_DIR";

AUDIOINFO=$(mediainfo "$AUDIO_FILE" --Output=JSON);
DURATION=$(echo -e "$AUDIOINFO" | jq -r '.media.track[0].Duration');

TOTAL_TRACKS=$(cat "$TIMESTAMPS_FILE" | wc -l);

add_tags() { ~/scripts/music/tag.sh "$@"; }

padd() { printf "%0${2:-2}d" $(echo $1 | cut -d'.' -f1); }

to_timestamp() {
  local duration=$1;
  local hours=$(echo "$duration / 3600" | bc);
  duration=$(echo "$duration % 3600" | bc);
  local mins=$(echo "$duration / 60" | bc);
  local secs=$(echo "$duration % 60" | bc);
  echo "$(padd $hours):$(padd $mins):$(padd $secs)";
}

starttime="";
music="";
index=0;

(cat "$TIMESTAMPS_FILE"; echo "<<END") | while read split; do
  if [[ ! -z "$split" ]]; then
    if [[ "$split" == "<<END" ]]; then
      endtime=$(to_timestamp $DURATION);
    else
      endtime="$(echo $split | cut -d' ' -f1)";
      nextmusic="$(echo $split | cut -d' ' -f 2-)";
    fi;

    if [[ ! -z "$music" ]]; then
      output="$OUT_DIR/$(padd $index) - $music.$EXT";
      echo "$starttime - $endtime ($output)";
      ffmpeg \
        -nostdin -y \
        -loglevel -8 \
        -i "$AUDIO_FILE" \
        -ss "$starttime" \
        -to "$endtime" \
        -vn "$output" && \
      add_tags \
        -a "$ARTIST" \
        -A "$ALBUM" \
        -t "$music" \
        -n "$music" \
        -N "$TOTAL_TRACKS" \
        "$output" \
      ;
    fi;

    music=$nextmusic;
    starttime=$endtime;
    index=$((index + 1));
  fi;
done;
