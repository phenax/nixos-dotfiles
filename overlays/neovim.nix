self: super: {
  tree-sitter-updated = super.tree-sitter.overrideAttrs (
    oldAttrs: {
      postInstall = ''PREFIX=$out make install'';
    }
  );
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (
    oldAttrs: rec {
      name = "neovim-nightly";
      version = "0.5-nightly";
      src = self.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "nightly";
        sha256 = "1h1idmlyvydkihfr2n1bsp8c2w9jnlgvm7jqc0gmr4cvwaflcydf";
      };

      nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
    }
  );
}
