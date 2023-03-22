fzf-change-dir() {
  local result=$(find -type d | fzf);

  if ! [[ -z "$result" ]]; then
    cd "$result"
  fi

  zle send-break
}

zle -N fzf-change-dir;
bindkey '^P' fzf-change-dir;
