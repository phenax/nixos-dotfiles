#!/usr/bin/env bash
source "$HOME/scripts/modules/rofi-menu.sh";
source "$HOME/scripts/modules/utils.sh";

optn_poweroff="[] off";
optn_reboot="[] reboot";
optn_suspend="[] suspend";
optn_logout="[] logout";
optn_lock="[] lock";
optn_cancel="[] cancel";

OPTIONS=$(echo -e "
$optn_poweroff
$optn_reboot
$optn_suspend
$optn_logout
$optn_lock
$optn_cancel
" | trim);

lock() { bslock; }
logout_() { ~/.config/autostart.sh kill; killall dwm; }
poweroff_() { systemctl poweroff; }
reboot_() { systemctl reboot; }
suspend_() { lock & disown; sleep 0.3; sudo zzz; }

menu() {
  result=$(echo -e "$OPTIONS" | open-menu -l 0 -p "Power button");
  case "$result" in
    "$optn_lock")      lock ;;
    "$optn_logout")    logout_ ;;
    "$optn_poweroff")  poweroff_ ;;
    "$optn_reboot")    reboot_ ;;
    "$optn_suspend")   suspend_ ;;
  esac
}

case "$1" in
  menu) menu ;;
  lock) lock ;;
  poweroff) poweroff_ ;;
  reboot) reboot_ ;;
  *) exit 1 ;;
esac

