let
  rev = "14a21b492d6acd79495b14c9d127a94b77c0b72c"; # (24 Dec 2025)
in
  import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
  })
