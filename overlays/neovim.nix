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
        sha256 = "05aswlzgqjy2v6ryh9mn0gskxq12xsl31pds6r69d0hdx9hcv1sj";
      };

      nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
    }
  );
}
