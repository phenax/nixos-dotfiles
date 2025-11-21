{ pkgs ? import <nixpkgs> {}, ... }:
let
  debUrl = "https://www.tenable.com/downloads/api/v1/public/pages/nessus-agents/downloads/26786/download?i_agree_to_tenable_license_agreement=true";

  setupNessusAgentDir = pkgs.writeShellScriptBin "setup-nessus-agent-dir" ''
    set -eu -o pipefail
    outdir=/opt/nessus_agent
    if ! [ -f "$outdir/.installed" ]; then
      echo "First install setup"
      mkdir -p "$outdir"
      cp -rf ${nessus-files}/nessus/* "$outdir"
      chmod -R 755 "$outdir"
      touch "$outdir/.installed"
    fi
  '';

  nessus-files = pkgs.stdenv.mkDerivation {
    pname = "nessus-files";
    version = "11.0.2";
    nativeBuildInputs = [ pkgs.dpkg ];
    src = pkgs.fetchurl {
      url = debUrl;
      sha256 = "sha256-TlO7l50sqILcF/xga+RifvzptcSBk/PGqunhJYzUFYA=";
    };
    dontConfigure = true;
    dontBuild = true;
    unpackPhase = ''dpkg-deb -x $src .'';
    installPhase = ''
      mkdir -p $out/nessus
      mv opt/nessus_agent/* $out/nessus
    '';
  };
in
pkgs.buildFHSEnv {
  name = "nessus-agent-fhs";

  targetPkgs = pkgs: with pkgs; [
    coreutils
    openssl_3
    nettools
    iproute2
    procps
    util-linux
    glibc
    zlib
    sqlite
  ];

  profile = ''
    export NESSUS_TZ_DIR=/etc/zoneinfo;
    export PATH="$PATH:/opt/nessus_agent/bin:/opt/nessus_agent/sbin"
  '';

  runScript = ''bash -c '
    echo "Starting service with args: $@";
    ${setupNessusAgentDir}/bin/setup-nessus-agent-dir;
    "$@";
  ' -- '';
}
