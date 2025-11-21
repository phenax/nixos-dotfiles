#!/usr/bin/env sh

set -eu -o pipefail

CONFIG_ORG_DIRECTORY=${CONFIG_ORG_DIRECTORY:-"$HOME/nixos/extras/notes"}

datefmt='%Y-%m-%d'
datetimefmt='%Y-%m-%d %H:%M:%S'

weekdaynum() { echo "$(($(date -d "$1" +%u) % 7))"; }

today=$(date "+$datefmt")
weekincrement="${1:-0}"
target=$(date -d "$weekincrement weeks" "+$datefmt")
weekstart=$(date -d "$target -$(weekdaynum "$target") days" "+$datefmt")
nextweekstart=$(date -d "$target -$(weekdaynum "$target") days +1 week" "+$datefmt")

fetch_schedule() {
  # TODO: Exclude DONE tasks
  rg -i -g '**/*.org' --vimgrep --multiline \
    '^\*+\s+(?<heading>.+)\n(^[^*]*\n)*^((?<type>SCHEDULED|DEADLINE)\s*:)?\s*<(?<date>[^>]*)>(--<(?<enddate>[^>]*)>)?' \
    --replace '§$heading§$type§$date§$enddate' \
    "$CONFIG_ORG_DIRECTORY" \
    | sed -E 's/:[0-9]+:[0-9]+://'
}

# :: Date -> Date
parse_start_date() {
  echo "$1" | sed -E 's/^([0-9]+-[0-9]+-[0-9]+)\s*.*/\1/'
}

# :: ScheduleType -> Date -> End Date -> [Date]
parse_date_range() {
  [ -z "$2" ] && return 0
  parsed_date=$(parse_start_date "$2")
  if [ "$1" = "DEADLINE" ]; then
    for i in $(seq 1 2); do
      local d=$(date -d "$parsed_date -$i days" "+$datefmt" || true)
      if [ "$d" \> "$today" ] || [ "$d" = "$today" ]; then echo "$d"; fi
    done
    date -d "$parsed_date" "+$datefmt" || true
  else
    # TODO: Parse end date
    # TODO: Parse repeat syntax +x as well
    date -d "$parsed_date" "+$datefmt" || true
  fi
}

date_between() {
  ([ "$1" \> "$2" ] || [ "$1" = "$2" ]) && [ "$1" \< "$3" ]
}

weeks_events() {
  fetch_schedule | while IFS=§ read file heading scheduletype original_date end_date; do
    parse_date_range "$scheduletype" "$original_date" "$end_date" | while IFS= read applied_date; do
      day_of_week=$(date -d "$applied_date" +%A 2>/dev/null || true)
      if ! [ -z "$applied_date" ] && (date_between "$applied_date" "$weekstart" "$nextweekstart"); then
        parsed_date="$(parse_start_date "$original_date")"
        echo -e "$day_of_week§$heading§$scheduletype§$original_date§$parsed_date§$applied_date"
      fi
    done
  done
}

date_from_day() {
  date -d "$weekstart +$(weekdaynum "$1") days" +"$datefmt";
}

relative_date_diff() {
  start_sec=$(date -d "$1" +%s)
  end_sec=$(date -d "$2" +%s)
  diff=$((end_sec - start_sec))
  days=$((diff / 86400))
  if [ $diff = 0 ]; then     echo "today"
  elif [ $diff -gt 0 ]; then echo "in $days days"
  else                       echo "$((days * -1)) days ago"
  fi
}

events=$(weeks_events)
cols=$(tput cols)

days_of_week="Sunday Monday Tuesday Wednesday Thursday Friday Saturday"

for day_of_week in ${days_of_week}; do
  echo -e "\033[38;5;73m${day_of_week} \033[1m($(date_from_day "$day_of_week"))\033[0m"
  (echo "$events" | grep "^$day_of_week" || true) | \
    while IFS=§ read _ heading scheduletype original_date real_date date; do
      eventstyle=""
      if [ "$scheduletype" = "DEADLINE" ]; then
        eventstyle=$([ "$date" = "$real_date" ] \
                      && echo "\033[38;5;160m" \
                      || echo "\033[38;5;172m")
      fi
      printf "\033[38;5;243m%${cols}s\033[0m" "($original_date) "
      echo -e "\r    ${eventstyle}\033[1m${heading}\033[0m ($(relative_date_diff "$today" "$real_date"))"
    done
done
