{ config , lib , pkgs , ... }:
let
  secfix-agent = pkgs.stdenv.mkDerivation {
    pname = "secfix-agent";
    version = "1.0.0";

    src = ./secfix.linux-systemd-deb.deb;

    nativeBuildInputs = with pkgs; [ autoPatchelfHook zlib dpkg ];

    sourceRoot = ".";
    unpackCmd = ''dpkg-deb -x "$src" .'';

    dontBuild = true;
    installPhase = ''
      mkdir -p $out/;
      cp -r ./* $out/;
      sed -i \
        -e "s|/var/|$out/var/|" \
        -e "s|/etc/|$out/etc/|" \
        -e "s|/usr/|$out/usr/|" \
        $out/etc/secfix/launcher.flags;
    '';
  };
in

{
  options.services.secfix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''Secfix agent'';
    };
  };

  config = let
    cfg = config.services.secfix;
  in
    lib.mkIf cfg.enable {
      environment.systemPackages = [ secfix-agent ];

      systemd.services.secfix = {
        unitConfig = {
          Description = "The Kolide Launcher";
          After = "network.service syslog.service";
        };

        serviceConfig = {
          ExecStart =
            "${secfix-agent}/usr/local/secfix/bin/launcher -config ${secfix-agent}/etc/secfix/launcher.flags --root_directory /var/run/secfix/";
          Restart = "on-failure";
          RestartSec = 3;
        };

        wantedBy = ["multi-user.target"];
      };
    };
}
