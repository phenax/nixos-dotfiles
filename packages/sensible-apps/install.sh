apps="
sensible-terminal           $TERMINAL
sensible-editor             $EDITOR
sensible-browser            $BROWSER
sensible-private-browser    $PRIVATE_BROWSER
";

BIN=$out/bin;

echo -e "$apps" | while read app bin; do
  if [[ ! -z "$bin" ]]; then
    echo "[SENSIBLE_APPS]:: Setting $app to $bin ($BIN/$bin)";
    mkdir -p $BIN;
    echo -e "#!/usr/bin/env sh\nexec $bin \"\$@\"" > $BIN/$app;
    chmod +x $BIN/$app;
  fi;
done;

