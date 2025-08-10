let
  rev = "95727f7d4ebe43435c826ab618933198ab30effe"; # "master" (6th Aug 2025)
in
  import (builtins.fetchTarball {
    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/${rev}.tar.gz";
  })
