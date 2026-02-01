{ config, pkgs, ... }:
{
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-poi
      gh-notify
      # gh-dash
    ];
    settings = {
      aliases = {
        clean-branches = "poi";
        pv = "pr view";
        co = "pr checkout";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      dark = true;
      side-by-side = true;
      line-numbers = true;
      hyperlinks = true;
      paging = "always";
      diff-so-fancy = true;
      file-decoration-style = "brightcyan bold ol ul";
      file-style = "brightcyan";
      hunk-header-decoration-style = "white ul";
    };
  };

  programs.git = {
    enable = true;
    ignores = [
      "tags"
      ".vim.session"
      "tags.lock"
      "tags.temp"
      "ayak.sh"
      ".direnv"
      ".local.lua"
      ".nvim.lua"
    ];
    settings = {
      user.email = "phenax5@gmail.com";
      user.name = "Akshay Nair";
      alias = {
        ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
        dshow = "-c diff.external='difft --display side-by-side-show-both' show --ext-diff";
        ddiff = "-c diff.external='difft --display side-by-side-show-both' diff";
      };
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
      pull.rebase = true;
      rebase.autosquash = true;
      # diff.tool = "nvimdiff";
      # merge.tool = "nvimdiff";
      merge.conflictStyle = "zdiff3";
      difftool.prompt = false;
      mergetool.prompt = false;
    };
    signing.key = "AAAB13AE8B82A5267C1A35D7E1B701723EA37849";
    signing.signByDefault = true;
  };

  # programs.gh-dash = {
  #   enable = true;
  #   settings = {
  #     defaults = {
  #       preview = {
  #         open = true;
  #         width = 80;
  #       };
  #     };
  #     pager = { diff = "delta"; };
  #     keybindings = {
  #       prs = [
  #         { key = "m"; command = "echo accident"; }
  #         { key = "x"; command = "echo accident"; }
  #         { key = "a"; command = "echo accident"; }
  #         { key = "A"; command = "echo accident"; }
  #         { key = "W"; command = "echo accident"; }
  #         { key = "X"; command = "echo accident"; }
  #       ];
  #     };
  #   };
  # };
}
