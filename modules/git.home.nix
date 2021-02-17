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
    ];
    aliases = {
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
    extraConfig = {
      "color" = {
        "ui" = true;
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
    };
    #signing.key = "GPG-KEY-ID";
    #signing.signByDefault = true;
  };
}
