# List files aliases
alias ll="ls -lh --time-style=+ --group-directories-first --color=always";
alias la='ls -A';
alias lsize='du -h -d1';

alias l='daffm';
alias lt='daffm';

# cd to navigated directory on quit
lc () {
  tmp="$(mktemp)"
  DAFFM_LAST_DIR_PATH="$tmp" daffm -c @lastcd
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
