#!/usr/bin/env bash

[[ $# != 2 ]] && echo "Usage: pass-migrate.sh <pass_dir> <key_file>" && exit 1;

PASS_DIR="$1";
KEY_FILE="$2";

to_passnames() { sed -e 's/^[./]*//g' -e 's/\.gpg$//g'; }

get_gpg_files() {
  cd "$PASS_DIR" 2> /dev/null;
  find . -regex '.*\.gpg';
}

get_gpg_files | to_passnames | while read key; do
  pass=$(pass show "$key");
  echo "$pass";
done;

