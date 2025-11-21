{ pkgs, ... }:
{
  imports = [ ./module.nix ];
  environment.systemPackages = [
    (pkgs.callPackage ./fhs.nix {})
  ];
}
