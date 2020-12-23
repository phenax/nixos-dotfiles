
BIN_DIR="$SCRIPTS_BINARY_DIR";
SCRIPT="$SCRIPTS_DIR";

_create_runner() {
  local name="$1";
  local filename="${2:-"$1.sh"}";
  local filepath="$SCRIPT/$filename";

  alias $name="$filepath";
}

_create_runner "artemis";
_create_runner "update-dotfiles" "dotfiles.sh";
_create_runner "session-box" "qutebrowser/session-box.sh";

scr() { ~/scripts/$@; }

