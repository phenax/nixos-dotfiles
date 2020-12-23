self: super: {
  qutebrowser = super.qutebrowser.override {
    python3 = super.python3.override {
      packageOverrides = self: super: {
        tldextract = super.tldextract.overridePythonAttrs(_: {
          propagatedBuildInputs = with super; [ requests requests-file idna filelock ];
          doCheck = false;
          pythonImportsCheck = ["tldextract"];
        });
      };
    };
  };
}
