{ pkgs, lib }:
pkgs.kakouneUtils.buildKakounePluginFrom2Nix {
  pname = "active-window.kak";
  version = "0.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "greenfork";
    repo = "active-window.kak";
    rev = "36bf0364eed856a52cddf274072e9f255902c0ee";
    sha256 = "sha256-6GLt9g20ddbXb29Vdl0YXFDWC73qip9cVU8EgdNlYbs=";
  };
}
