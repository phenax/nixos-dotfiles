{ lib, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color"; # tmux-256color
    escapeTime = 25;
    shortcut = "q";
    extraConfig = lib.readFile ./tmux.conf;
  };
}
