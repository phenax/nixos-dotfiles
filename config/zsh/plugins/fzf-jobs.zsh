
fzf-fg() {
  local job=$(jobs | fzf | sed 's/^\[\(.\+\)\].*/\1/g')
  if ! [ -z "$job" ]; then
    fg %"$job"
  fi;
  zle send-break || true
}

zle -N fzf-fg;
bindkey '^X' fzf-fg;
