{ config, lib, ... }:
with lib;
let
  cfg = config.services.service-router;
  hostname = name: "${name}.local";
in {
  options.services.service-router = {
    enable = mkEnableOption "enable router";
    routes = mkOption {
      type = types.attrsOf (types.submodule { options = {
        port = mkOption { type = types.int; };
        host = mkOption { type = types.str; default = "127.0.0.1"; };
        protocol = mkOption { type = types.str; default = "http"; };
      }; });
      default = {};
    };
  };

  config = lib.mkIf cfg.enable {
    services.nginx = {
      enable = true;
      virtualHosts = lib.mapAttrs' (name: val: {
        name = hostname name;
        value = {
          locations."/" = {
            proxyPass = "${val.protocol}://${val.host}:${toString val.port}";
          };
        };
      }) cfg.routes;
    };

    networking.hosts."127.0.0.1" = lib.mapAttrsToList (name: _: hostname name) cfg.routes;
  };
}
