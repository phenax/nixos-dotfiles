
fzf-change-dir-cwd() { # fzf + cd in cwd
  selected=$(find . -maxdepth 1 -type d | fzf);
  if [ ! -z "$selected" ] && [ "$selected" != "$(pwd)" ]; then
    cd $selected;
  fi
  zle send-break || true
}

zle -N fzf-change-dir-cwd;
bindkey '^O' fzf-change-dir-cwd;

fzf-change-dir() {
  local result=$(find -type d | fzf);
  if ! [[ -z "$result" ]]; then
    cd "$result"
  fi
  zle send-break || true
}

zle -N fzf-change-dir;
bindkey '^F' fzf-change-dir;
