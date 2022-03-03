{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "phenax5@gmail.com";
    userName = "Akshay Nair";
    ignores = [
      "tags"
      ".vim.session"
      "tags.lock"
      "tags.temp"
      "ayak.sh"
    ];
    aliases = {
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
    extraConfig = {
      "color" = {
        "ui" = true;
      };
      "init" = {
        defaultBranch = "main";
      };
      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };
      "color \"diff\"" = {
        meta = 11;
        frag = "magenta bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
      #"pull" = { rebase = true; };
    };
    signing.key = "AAAB13AE8B82A5267C1A35D7E1B701723EA37849";
    signing.signByDefault = true;
  };
}
