{ pkgs, ... }:
let
  # daffm-pkg = (builtins.getFlake "github:phenax/daffm/b61d4cdc759e08eb7990aa7f3a67eb737cd7b930").packages.x86_64-linux.default
  daffm-pkg = pkgs.writeShellScriptBin "daffm" ''exec /home/imsohexy/dev/projects/daffm/result/bin/daffm "$@"'';
in
{
  home.packages = [
    daffm-pkg
  ];

  home.file = {
    ".config/daffm".source = ./config;
  };
}
