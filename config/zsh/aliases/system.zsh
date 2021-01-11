
# Pacman aliases

alias auto-remove="sudo nix-collect-garbage -d && nix-store --optimize";

#alias mirrorlist-refresh="sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist-arch"

# Sandbox
#alias sandbox="sudo ~/scripts/host-file-elb-update.sh";

# Runit helpers
#sv_enable() { [[ -f "/etc/runit/sv/$1" ]] && sudo ln -s /etc/runit/sv/$1 /run/runit/service; }
#sv_disable() { sudo unlink /run/runit/service/$1; }

