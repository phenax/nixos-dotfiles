# with import <nixpkgs> {};
# let src = fetchFromGitHub {
#       owner = "mozilla";
#       repo = "nixpkgs-mozilla";
#       rev = "9f35c4b09fd44a77227e79ff0c1b4b6a69dff533";
#       sha256 = "18h0nvh55b5an4gmlgfbvwbyqj91bklf1zymis6lbdh75571qaz0";
#    };
# in
# with import "${src.out}/rust-overlay.nix" pkgs pkgs;
# stdenv.mkDerivation {
#   name = "rust-env";
#   buildInputs = [
#     # Note: to use use stable, just replace `nightly` with `stable`
#     latest.rustChannels.nightly.rust
# 
#     # Add some extra dependencies from `pkgs`
#     pkgconfig openssl
#   ];
# 
#   # Set Environment Variables
#   RUST_BACKTRACE = 1;
# }

with import <nixpkgs> {};
mkShell rec {
  buildInputs = [
    # Build tools
    rustup
    pkg-config

    # Deps
    libclang

    # Dev
    nodePackages.nodemon
    rust-analyzer
  ];
  nativeBuildInputs = [ clang ];

  LIBCLANG_PATH = "${libclang.lib}/lib";
  RUST_SRC_PATH = rust.packages.stable.rustPlatform.rustLibSrc;
  LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);
}
