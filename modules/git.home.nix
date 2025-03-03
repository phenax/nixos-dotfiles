{ config, pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-copilot
      gh-poi
      gh-dash
      gh-notify
    ];
    settings = {
      aliases = {
        clean-branches = "poi";
        pv = "pr view";
        co = "pr checkout";
      };
    };
  };

  programs.gh-dash = {
    enable = true;
    settings = {
      defaults = {
        preview = {
          open = true;
          width = 80;
        };
      };
      pager = { diff = "delta"; };
      keybindings = {
        prs = [
          { key = "m"; command = "echo accident"; }
          { key = "x"; command = "echo accident"; }
          { key = "a"; command = "echo accident"; }
          { key = "A"; command = "echo accident"; }
          { key = "W"; command = "echo accident"; }
          { key = "X"; command = "echo accident"; }
        ];
      };
    };
  };

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
      ".direnv"
      ".local.lua"
    ];
    aliases = {
      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      dshow = "-c diff.external='difft --display side-by-side-show-both' show --ext-diff";
      ddiff = "-c diff.external='difft --display side-by-side-show-both' diff";
    };
    delta = {
      enable = true;
      # package = pkgs.delta;
      options = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
      };
    };
    # difftastic = {
    #   enable = true;
    #   display = "side-by-side";
    #   color = "auto";
    #   background = "dark";
    # };
    extraConfig = {
      color = {
        ui = true;
      };
      init = {
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
      pull = {
        rebase = true;
      };
      # pager = {
      #   diff = "${pkgs.delta}/bin/delta --color-only";
      # };
    };
    signing.key = "AAAB13AE8B82A5267C1A35D7E1B701723EA37849";
    signing.signByDefault = true;
  };
}
