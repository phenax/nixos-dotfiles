function preexec() {
  timer=$(($(date +%s%0N)/1000000))
  echo -n "\\x1b]133;A\\x1b\\" # OSC 133 for marking prompt
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    export RPROMPT="%F{cyan}${elapsed}ms %{$reset_color%}"
    unset timer
  fi
}
