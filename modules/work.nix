{ ... }:
{
  imports = [
    ./secfix/default.nix
    ./nessus-daemon/default.nix
  ];

  services.nessus-agent = {
    enable = true;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  services.secfix = {
    enable = true;
  };
}
