{ ... }:
{
  imports = [
    ./secfix/default.nix
  ];

  services.secfix.enable = true;
}
