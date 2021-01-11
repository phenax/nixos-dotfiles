self: super: {
  tree-sitter-updated = super.tree-sitter.overrideAttrs (oldAttrs: {
    postInstall = ''PREFIX=$out make install'';
  });
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    name = "neovim-nightly";
    version = "0.5-nightly";
    src = self.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "nightly";
      sha256 = "019dl8w0l2b0bk26irfgnl6dal1pisdwn1qy4b36hvij2y5mad3s";
    };

    nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
  });
}
