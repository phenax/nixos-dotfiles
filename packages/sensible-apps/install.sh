apps="
sensible-terminal           exec $TERMINAL
sensible-editor             exec $EDITOR
sensible-browser            $BROWSER
sensible-private-browser    $PRIVATE_BROWSER
";

BIN=$out/bin;

mkdir -p $BIN;

echo -e "$apps" | while read app bin; do
  if [[ ! -z "$bin" ]]; then
    echo "[SENSIBLE_APPS]:: Setting $app to $bin ($BIN/$bin)";
    mkdir -p $BIN;
    echo -e "#!/usr/bin/env sh\n $bin \"\$@\"" > $BIN/$app;
    chmod +x $BIN/$app;
  fi;
done;

