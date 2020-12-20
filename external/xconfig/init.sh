#!/usr/bin/env sh

NIX_X="$HOME/nixos/external/xconfig";

# Xresources (theme)
xrdb -merge $NIX_X/Xresources;

# Xmodmap (keymapping)
xmodmap $NIX_X/Xmodmap;

# No screen saver
xset s off;
xset -dpms;
xset s noblank;

# Typing rate
xset r rate 350 30;

# Display settings
# ~/scripts/commands/:day

# Sound
#~/scripts/sound.sh mic-vol full;
#~/scripts/sound.sh mute-mic;
#~/scripts/sound.sh mute;

