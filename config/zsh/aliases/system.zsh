
# Pacman aliases
alias auto-remove="yay -Rcs \$(yay -Qdtq)";
alias update="yay -Syu";
alias mirrorlist-refresh="sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist-arch"

# Sandbox
alias sandbox="sudo ~/scripts/host-file-elb-update.sh";

# Runit helpers
sv_enable() { [[ -f "/etc/runit/sv/$1" ]] && sudo ln -s /etc/runit/sv/$1 /run/runit/service; }
sv_disable() { sudo unlink /run/runit/service/$1; }

