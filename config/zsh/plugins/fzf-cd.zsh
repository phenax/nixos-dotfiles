
fzf-change-dir-cwd() { # fzf + cd in cwd
  selected=$(fd --type d --maxdepth 1 --hidden --no-ignore | fzf);
  if [ ! -z "$selected" ] && [ "$selected" != "$(pwd)" ]; then
    cd $selected;
  fi
  zle send-break || true
}

zle -N fzf-change-dir-cwd;
bindkey '^O' fzf-change-dir-cwd;

fzf-change-dir() {
  local result=$(fd --type d --hidden --no-ignore | fzf);
  if ! [[ -z "$result" ]]; then
    cd "$result"
  fi
  zle send-break || true
}

zle -N fzf-change-dir;
bindkey '^F' fzf-change-dir;
