self: super: {
  tree-sitter-updated = super.tree-sitter.overrideAttrs(oldAttrs: {
    postInstall = ''
        PREFIX=$out make install;
    '';
  });
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    name = "neovim-nightly";
    version = "0.5-nightly";
    src = self.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "nightly";
      sha256 = "0vpjdd32lgzyh85gyazqpms8vmaad6px3zx2svdxhvcdxgschqz9";
    };

    nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
  });
}
