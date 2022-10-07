{ pkgs
, lib
, stdenv
, ghc
, haskellPackages
}:
let
  xmobar-custom = haskellPackages.xmobar.overrideAttrs (
    _: {
      configureFlags = [
        "-fwith_xft"
        "-fwith_threaded"
        "-fwith_rtsopts"
        "-fwith_alsa"
        "-fwith_utf8"
        "-fwith_nl80211"
      ];
    }
  );
in
haskellPackages.mkDerivation rec {
  pname = "local-xmonad-${version}";
  version = "0.0.1";
  license = lib.licenses.mit;

  src = ./source;

  isLibrary = false;
  isExecutable = true;
  doHaddock = false;

  libraryHaskellDepends = with haskellPackages; [
    base
    containers
    extensible-exceptions
    parsec
    process
    X11
    xmonad
    xmonad-contrib

    xmobar-custom
  ];

  librarySystemDepends = with pkgs; [
    pkgs.pkg-config
    xorg.libXext
    xorg.libXScrnSaver
    xorg.libXinerama
    xorg.libXrender
    xorg.libX11
    xorg.libXrandr
    xorg.libXft
    xorg.libXpm
    alsa-lib
    wirelesstools
  ];
}
