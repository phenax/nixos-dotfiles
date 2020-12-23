#!/usr/bin/env bash

source "$HOME/scripts/modules/utils.sh";

SCH_PATH="$HOME/.config/vimwiki/schedule/";
SCH_TAG="SCH_AUTO_GENERATED";
CRON_PATH="$HOME/.config/crontab/crontab";

get_schedule_files() {
  ls "$SCH_PATH" | sed -e '/index.md$/d' | awk "{print \"$SCH_PATH\" \$0}";
}

get_time() { awk -F'|' '{print $2}' | trim_line; }
get_label() { awk -F'|' '{print $3}' | trim_line; }
get_level() {
  local l=$(awk -F'|' '{print $4}' | trim_line);
  case $l in
    1) echo "critical" ;;
    2) echo "normal" ;;
    3) echo "low" ;;
    *) echo "" ;;
  esac
}

parse_schedule() {
  local days="$1";

  sed -e '/^#/d' -e '/^\s*$/d' | while read line; do
    local time=$(echo "$line" | get_time);
    local level=$(echo "$line" | get_level);

    if [[ ! $time == "-" ]] && [[ ! $level == "" ]]; then
      local label=$(echo "$line" | get_label);
      local time_cron=$(echo $time | awk '{print $2 " " $1}');
      # TODO: Use notify sub command
      local command="notify-send '$label' -u $level -a Schedule -t 10000";

      echo "$time_cron $days      $command ##$SCH_TAG";
    fi;
  done;
}

generate_crontab() {
  get_schedule_files | while read file; do
    days=$(cat $file | awk -F'#' '/^# / {print $2}' | head -n 1 | trim_line)
    parse_schedule "$days" < $file;
  done
}

update_crontab() {
  cat $CRON_PATH | sed -e "/##$CRON_TAG/d";
  generate_crontab;
}

# TODO: Make generate and notify sub commands
# case "$1" in
  # *) ;;
# esac

tmpfile=$(mktemp /tmp/crontemp.XXX);
update_crontab > $tmpfile;
cat $tmpfile > $CRON_PATH;
rm $tmpfile;

