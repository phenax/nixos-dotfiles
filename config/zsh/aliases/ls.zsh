# Trash
alias trash="ls \$TRASH_TMP_DIR";

# List files aliases
alias ls="lsd";
alias l="ls -1";
alias la='ls -a';
alias ll='ls -alF';
alias lt='ls --tree';
alias la='ls -A';
alias lsize='du -h -d1';

lc () { # lf with cd to navigated directory on quit
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}

lfshow() {
  local TMP_F="$(mktemp)";
  lf -selection-path "$TMP_F" "$@"  >/dev/null 2>&1;
  local res="$(< "$TMP_F")";
  rm -f "$TMP_F";
  echo "$res"
}
