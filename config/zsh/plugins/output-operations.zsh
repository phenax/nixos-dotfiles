# TODO

# logoutputdir=$(mktemp -d /tmp/zsh-output-operations.XXXXXXXX/)

output-file() {
  local termid=$(tty | sed 's|/|-|g');
  echo "$logoutputdir/last-output-$termid";
}

xz() {
  "$@" |& tee $(output-file);
}

# Cleanup
function plugin-exit-handler {
  rm -f $(output-file);
}

# trap plugin-exit-handler EXIT
