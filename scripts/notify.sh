#!/bin/bash
# All the wrapping wierdness to add support for cron
# https://wiki.archlinux.org/index.php/Desktop_notifications#Usage_in_programming

user=$(whoami);

sudo -u $user DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $user)/dbus-1 notify-send "$@";

