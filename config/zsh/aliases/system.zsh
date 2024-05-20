
# Pacman aliases

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
  v4l2-ctl -d /dev/video3 \
    --set-ctrl brightness=0 \
    --set-ctrl contrast=11 \
    --set-ctrl saturation=16 \
    --set-ctrl gamma=194 \
    --set-ctrl gain=60 \
    --set-ctrl sharpness=3 \
    --set-ctrl exposure_time_absolute=350;
}

setup_webcam_night() {
  v4l2-ctl -d /dev/video3 \
    --set-ctrl brightness=1 \
    --set-ctrl contrast=11 \
    --set-ctrl saturation=17 \
    --set-ctrl gamma=230 \
    --set-ctrl gain=64 \
    --set-ctrl sharpness=5 \
    --set-ctrl exposure_time_absolute=500;
}

# Run a program with limited memory
limit_memory() {
  local lim=${1:-100M}; shift 1;
  systemd-run --user --scope -p MemoryHigh="$lim" -p MemorySwapMax="$lim" "$@";
}
