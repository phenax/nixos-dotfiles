full_history() {
  [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1;
}

trim() { sed 's/^\s*//g'; }
reverse() { sed -n '1!G;h;$p'; }
unique() { awk '!seen[$0]++'; }

search_history() {
  local result=$(full_history | trim | cut -d' ' -f 2- | reverse | unique | fzf);

  # Replace the buffer with the editor output.
  print -Rz - "$(echo -n "$result" | trim)";

  zle send-break		# Force reload from the buffer stack
}

zle -N search_history;
bindkey '^R' search_history;
