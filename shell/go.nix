{}:
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "goenv";
  buildInputs = with pkgs; [ go gopls golangci-lint ];
  shellHook = ''
    export GOROOT="${pkgs.go.out}/share/go";
  '';
}
