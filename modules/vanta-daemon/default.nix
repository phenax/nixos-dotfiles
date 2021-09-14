{ stdenv
, fetchurl
, dpkg
, autoPatchelfHook
, zlib
}:
let
  version = "2.0.0";
in
stdenv.mkDerivation {
  name = "vanta-daemon-${version}";

  src = fetchurl {
    url = "https://vanta-agent-repo.s3.amazonaws.com/targets/versions/${version}/vanta-amd64.deb";
    sha256 = "0255is8psx808x99zna58nr3kf7j5vmydffchm5lbfz21qz09sal";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    zlib
    dpkg
  ];

  sourceRoot = ".";
  unpackCmd = ''dpkg-deb -x "$src" .'';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -a etc var $out
    cp -a usr/share/ $out/
    cp usr/lib/systemd/system/vanta.service $out/share/doc/vanta/

    mkdir -p $out/bin/;
    cp var/vanta/* $out/bin/
  '';
}
