self: super: {
  qutebrowser =
    let oldPkg = super.qutebrowser.override {
      python3 = super.python3.override {
        packageOverrides = self: super: {
          tldextract = super.tldextract.overridePythonAttrs (_: {
            propagatedBuildInputs = with super; [ requests requests-file idna filelock ];
            doCheck = false;
            pythonImportsCheck = [ "tldextract" ];
          });
        };
      };
    };
    in oldPkg;
  #mesa = super.mesa.overrideAttrs (_: {
  #version = "21.2.5";
  #});
}
# 21.2.5-1
