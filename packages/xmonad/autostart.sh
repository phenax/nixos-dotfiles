source ~/.config/zsh/paths.zsh;
source ~/.config/zsh/config.zsh;

##### Helpers {{{
action="$1";

# Is logout command (Cleanup)
is_kill() { [[ "$action" == "kill" ]]; }

# Focus on a tag/ws
focus_tag() { [[ ! -z "$1" ]] && dwmc view $(($1 - 1)); sleep 0.2; }

# Only run when there are no windows on the screen
on_startup() { is_kill || [[ "$(wmctrl -l | wc -l)" = "0" ]] && $@ & }

# Run only once. If an instance is already running, noop
once() {
  local name=$1; shift;
  if (is_kill); then
    pkill "$name";
  else
    pgrep $name || $@ &
  fi;
}

# Kill previous instance and run again
run() {
  local name=$1; shift;
  [[ ! -z "$name" ]] && pkill "$name" && sleep 0.05;
  is_kill || $@ &
}
# }}}


##### Autostart {{{
  echo "[Autostart]: Running daemons";

  # Key daemon
  run "shotkey" shotkey;

  # Wallpaper
  run "" ~/.fehbg;

  # Notification daemon
  run "dunst" dunst -config ~/.config/dunst/dunstrc;

  # Compositor
  run "picom" picom --config ~/.config/picom.conf;

  # Scheduler
  run "remind" remind -k"notify-send -a reminder %s" -z10 $REMINDER_FILE;

  # Battery watcher
  run "" ~/scripts/battery-watch.sh start;

  # Disk automount
  #once "udiskie" ~/.bin/with_zsh udiskie;

  # Clipboard history
  #once "clipmenud" clipmenud;

  # Network manager applet
  #once "nm-applet" nm-applet;

  # Syncthing
  #run "syncthing" syncthing -logflags=0 -no-browser 2>&1 >/dev/null;

  # Torrent daemon
  #once "btpd" btpd -d "$HOME/.config/btpd";
  #once "transmission" transmission-daemon --download-dir ~/Downloads/dl;

  # Music daemon
  #once "mpd" mpd ~/.config/mpd/mpd.conf --stdout --no-daemon;

  # Hide mouse pointer
  #once "unclutter" unclutter;
# }}}


##### Initialized applications {{{
echo "[Autostart]: Checking applications";
#on_startup sensible-browser;

applications() {
  #sleep 0.5;

  #focus_tag 9;
  #on_startup :today;
  #on_startup :tasks;

  #focus_tag 6;
  #on_startup sensible-browser;

  #focus_tag 1;
}

applications &

# }}}


disown;
