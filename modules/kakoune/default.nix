{ pkgs, lib, ... }:
with pkgs;
let
  my-kakoune = kakoune.override {
    plugins = with kakounePlugins; [
      kak-ansi
      (import ./kak-active-window.nix { inherit pkgs lib; })
    ];
  };
  kak-tree-sitter-unstable = import ./kak-tree-sitter.nix { inherit pkgs lib; };
  kakoune-lsp-unstable = import ./kakoune-lsp.nix { inherit pkgs lib; };
  kak-tmux = pkgs.writeShellScriptBin "kak-tmux" ''
    if [ -t 0 ] && [ -z "$TMUX" ]; then
      exec </dev/tty; exec <&1; ${tmux}/bin/tmux new "${my-kakoune}/bin/kak$(printf ' %q' "$@")"
    else
      exec "${my-kakoune}/bin/kak" "$@"
    fi
  '';
in
{
  environment.systemPackages = [
    my-kakoune
    # kakoune-lsp
    kakoune-lsp-unstable
    kakoune-cr
    kak-tree-sitter-unstable
    kak-tmux

    editorconfig-core-c
  ];
}
