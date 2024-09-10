{ lib, pkgs, ... }:
let
  cfg = import ./config.nix;
  urls = mergeFeeds [ (import ./public-feed.nix) privateFeed ];
  privateFeed = let feedpath = ./private-feed.nix;
    in if builtins.pathExists feedpath then import feedpath else {};

  mergeFeeds = feeds: lib.attrsets.foldAttrs (value: acc:
    if lib.isList value
      then value ++ (if acc != null then acc else [])
      else value // (if acc != null then acc else {})
  ) null ([{ queries = {}; visible = []; hidden = []; }] ++ feeds);

  joinLines = lib.concatStringsSep "\n";
  joinWords = lib.concatStringsSep " ";

  toUrl = url: joinWords (lib.map toString [
    url.url
    (lib.optional (url ? "hidden" && url.hidden) "!")
    (lib.optional (url ? "tags") (joinWords url.tags))
    (lib.optional (url ? "title") ''"~${url.title}"'')
  ]);

  toUrls = urls: joinLines (lib.map toUrl urls);

  toQueries = queries: joinLines
    (lib.mapAttrsToList (key: val: "\"query:${key}:${val}\"") queries);

  # { raw = a; } -> a | bool -> yesno | string -> "string" | number
  toConfigValue = val:
    if val ? "raw" then toString val.raw
    else if lib.isBool val then lib.hm.booleans.yesNo val
    else if lib.isString val then ''"${val}"''
    else toString val;

  cfgFileContent = joinLines [
    (joinLines
      (lib.mapAttrsToList (key: val: "${key} ${toConfigValue val}") cfg.config))
    (joinLines
      (lib.mapAttrsToList (key: val: "bind-key ${key} ${val}") cfg.keys))
    (joinLines
      (lib.mapAttrsToList (key: val: "macro ${key} ${val}") cfg.macros))
    cfg.extraConfig
  ];

  urlsFileContent = joinLines [
    (toQueries urls.queries)
    (toUrls urls.visible)
    (toUrls (lib.map (x: x // { hidden = true; }) urls.hidden))
  ];
in {
  home.packages = [ pkgs.newsboat ];

  xdg.configFile = {
    "newsboat/urls".text = urlsFileContent;
    "newsboat/config".text = cfgFileContent;
    "newsboat/opener.sh".source = ./opener.sh;
  };
}
