{ config, pkgs, ... }:
let
  vantaCreds = import ./vanta-daemon/credentials.nix;
in
{
  imports = [
    ./vanta-daemon/module.nix
  ];

  services.vanta = {
    enable = true;
    agentKey = vantaCreds.VANTA_KEY;
    email = vantaCreds.VANTA_OWNER_EMAIL;
  };
}
