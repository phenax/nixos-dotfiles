let
  rev = "928308a20559523bb3898861a6f28e9589ab3a0e"; # (19 Sept 2025)
in
  import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
  })
