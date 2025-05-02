{ ... }:
{
  imports = [
    ./secfix/default.nix
  ];

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  services.secfix.enable = true;
}
