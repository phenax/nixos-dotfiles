{ config, pkgs, ... }:
{
  services.kbfs.enable = true;
  services.keybase.enable = true;
}

