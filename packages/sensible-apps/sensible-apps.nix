let
  apps = {
    EDITOR = "nvim";
    TERMINAL = "st";
    BROWSER = "qutebrowser";
    PRIVATE_BROWSER = "qutebrowser ':open -p'";
  };
  package = { stdenv }: stdenv.mkDerivation rec {
    name = "local-sensible-apps-${version}";
    version = "0.0.1";

    src = [ ./install.sh ];

    unpackPhase = ''
      for srcFile in $src; do
        local tgt=$(echo $srcFile | cut --delimiter=- --fields=2-)
        cp $srcFile $tgt
      done
    '';

    installPhase = ''
      export TERMINAL="${apps.TERMINAL}";
      export EDITOR="${apps.EDITOR}";
      export BROWSER="${apps.BROWSER}";
      export PRIVATE_BROWSER="${apps.PRIVATE_BROWSER}";
      ls -la;
      sh ./install.sh
    '';
  };
in {
  package = package;
  apps = apps;
}
