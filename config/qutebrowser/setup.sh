#!/usr/bin/env bash

mkdir -p /tmp/backupDir;

link() {
  if [[ -f "$2" ]]; then
    return 0;
  else
    mv "$2" /tmp/backupDir/ 2> /dev/null
    ln -s "$1" "$2";
  fi
}

# Create userscripts symlink
link ~/.config/qutebrowser/userscripts ~/.local/share/qutebrowser/userscripts;

# Create greasemonkey symlink
link ~/.config/qutebrowser/greasemonkey ~/.local/share/qutebrowser/greasemonkey;

# Create sessions symlink
link ~/.work-config/qutebrowser/sessions ~/.local/share/qutebrowser/sessions;

