# with import <nixpkgs> { };
# let
#   src = fetchFromGitHub {
#     owner = "mozilla";
#     repo = "nixpkgs-mozilla";
#     rev = "15b7a05f20aab51c4ffbefddb1b448e862dccb7d"; # 10th April 2022
#     sha256 = "sha256-YeN4bpPvHkVOpQzb8APTAfE7/R+MFMwJUMkqmfvytSk=";
#   };
#   moz = import "${src.out}/rust-overlay.nix" pkgs pkgs;
#   rust = moz.latest.rustChannels.nightly.rust.override {
#     extensions = [ "rust-src" ];
#   };
# in
# mkShell rec {
#   buildInputs = [
#     # Build tools
#     rust
#
#     # Lib deps
#     pkg-config
#     libclang
#   ];
#   nativeBuildInputs = [ clang ];
#
#   # RUST_SRC_PATH = rust.packages.stable.rustPlatform.rustLibSrc;
#   # RUST_BACKTRACE = 1;
#   LIBCLANG_PATH = "${libclang.lib}/lib";
#   LD_LIBRARY_PATH = lib.makeLibraryPath (buildInputs ++ nativeBuildInputs);
# }

with import <nixpkgs> { };
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
