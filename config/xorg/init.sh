#!/usr/bin/env sh

# Xresources (theme)
xrdb -merge ~/.Xresources;

# Xmodmap (keymapping)
xmodmap ~/.config/xorg/Xmodmap;

# No screen saver
xset s off;
xset -dpms;
xset s noblank;

# Typing rate
xset r rate 350 30;

# Display settings
~/scripts/commands/:day

# Sound
amixer set Capture nocap;
amixer set Master off;

