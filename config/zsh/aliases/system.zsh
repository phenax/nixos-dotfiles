
# Pacman aliases

alias update="sudo nixos-rebuild switch --upgrade";
alias auto-remove="sudo nix-collect-garbage -d";

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

