
ROFI_BLOCK_THEME="$HOME/.config/rofi-themes/phenax-block-theme.rasi"

open-menu() { dmenu "$@"; }
open-block-menu() { rofi -i -dmenu -theme "$ROFI_BLOCK_THEME" "$@"; }

