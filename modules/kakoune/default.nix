{ pkgs, lib, ... }:
with pkgs;
let
  kak-tree-sitter-unstable = import ./kak-tree-sitter.nix { inherit pkgs lib; };
  kak-tmux = pkgs.writeShellScriptBin "kak-tmux" ''
    if [ -t 0 ] && [ -z "$TMUX" ]; then
      exec </dev/tty; exec <&1; ${tmux}/bin/tmux new "${kakoune}/bin/kak$(printf ' %q' "$@")"
    else
      exec "${kakoune}/bin/kak" "$@"
    fi
  '';
in {
  environment.systemPackages = [
    kakoune
    kakoune-lsp
    kakoune-cr
    kak-tree-sitter-unstable
    kak-tmux

    ripgrep
    tmux
    gitu
    moreutils
  ];
}
