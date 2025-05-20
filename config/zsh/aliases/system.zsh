alias copy="xclip -selection clipboard -i";

alias update="sudo nixos-rebuild switch --upgrade";
alias auto-remove="sudo nix-collect-garbage -d";
alias clean-boot-entries="sudo /run/current-system/bin/switch-to-configuration boot";

alias rebuild="sudo nixos-rebuild switch";
alias list-gens="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

nix-rollback() {
  [[ -z "$1" ]] && echo "Specify generation number: nix-rollback 330" && return 1;
  sudo nixos-rebuild switch --rollback=$1;
}

#alias mirrorlist-refresh="sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist-arch"

# Sandbox
#alias sandbox="sudo ~/scripts/host-file-elb-update.sh";

# Runit helpers
#sv_enable() { [[ -f "/etc/runit/sv/$1" ]] && sudo ln -s /etc/runit/sv/$1 /run/runit/service; }
#sv_disable() { sudo unlink /run/runit/service/$1; }

setup_webcam_day() {
  v4l2-ctl -d /dev/video2 \
    --set-ctrl brightness=1 \
    --set-ctrl contrast=13 \
    --set-ctrl saturation=15 \
    --set-ctrl gamma=150 \
    --set-ctrl gain=70 \
    --set-ctrl sharpness=3 \
    --set-ctrl exposure_time_absolute=400;
}

setup_webcam_night() {
  v4l2-ctl -d /dev/video2 \
    --set-ctrl brightness=2 \
    --set-ctrl contrast=12 \
    --set-ctrl saturation=13 \
    --set-ctrl gamma=160 \
    --set-ctrl gain=70 \
    --set-ctrl sharpness=2 \
    --set-ctrl exposure_time_absolute=520;
}

# Run a program with limited memory
limit_memory() {
  local lim=${1:-100M}; shift 1;
  systemd-run --user --scope -p MemoryHigh="$lim" -p MemorySwapMax="$lim" "$@";
}

# KDE connect aliases
phone() {
  local device=$(kdeconnect-cli -a --id-only)
  if [ -z "$device" ]; then
    echo "Device not found"
    return 1
  fi
  kdeconnect-cli --device "$device" "$@"
}
phone_file() { phone --share "$@"; }
phone_text() { phone --share-text "$@"; }
