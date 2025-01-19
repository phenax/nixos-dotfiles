{ stdenv, pkgs, lib, dmenu ? (import ../default.nix { pkgs = pkgs; }).dmenu }:
stdenv.mkDerivation rec {
  pname = "anypinentry";
  version = "0.1.1";
  meta.mainProgram = "anypinentry";

  src = ./source;

  buildInputs = [
    dmenu
    pkgs.getopt
    pkgs.coreutils
    pkgs.gnused
    pkgs.gawk
    pkgs.libnotify
  ];
  nativeBuildInputs = [ pkgs.makeWrapper ];

  unpackPhase = ''cp -r $src/* .'';
  installPhase = ''
    mkdir -p $out/bin;
    cp $src/anypinentry $out/bin/;
    wrapProgram "$out/bin/anypinentry" --prefix PATH : "/bin:${lib.makeBinPath buildInputs}";
  '';
}
