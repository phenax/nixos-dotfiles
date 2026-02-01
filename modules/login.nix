{ pkgs, ... }:
let
  sessions = [
    [ "tty1" windowManagers.dwm ]
    # [ "tty2" windowManagers.xmonad ]
  ];
  windowManagers = {
    dwm = looped "dwm";
    xmonad = exec "xmonad";
    bspwm = exec "bspwm";
  };
  exec = s: "exec ${s}";
  looped = s: ''
    while true; do
      ssh-agent ${s} || break;
    done
  '';
in
{

  users.groups = {
    uinput = { };
    storage = { };
    dialout = { };
  };

  # User
  users.users.imsohexy = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "input"
      "audio"
      "video"
      "storage"
      "git"
      "networkmanager"
      "docker"
      "transmission"
      "lxd"
      "jackaudio"
      "plugdev"
      "adbusers"
      "vboxusers"
      "uinput"
      "libvirtd"
      "dialout"
    ];
    shell = pkgs.zsh;
  };

  # Global
  environment.variables = let
    apps = (import ../packages/sensible-apps/sensible-apps.nix).apps;
  in {
    EDITOR = apps.EDITOR;
    VISUAL = apps.EDITOR;
    TERMINAL = apps.TERMINAL;
    BROWSER = apps.BROWSER;
    PRIVATE_BROWSER = apps.PRIVATE_BROWSER;
  };
  environment.sessionVariables = rec {
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [ "$HOME/scripts/bin" XDG_BIN_HOME ];
    LS_COLORS = "di=96:ln=36:or=31:mi=31:ex=32";
    XDG_SESSION_TYPE = "x11";
    FZF_DEFAULT_OPTS=''
      --color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626
      --color=hl:#007070,hl+:#007070,info:#007070,marker:#007070
      --color=prompt:#007070,spinner:#007070,pointer:#007070,header:#07afaf
      --color=border:#262626,label:#aeaeae,query:#d9d9d9
      --preview-window='sharp' --prompt=': ' --marker='>' --gutter=' ' --pointer=' '
      --layout=reverse --height 40% --info='right' --separator='-' --scrollbar=' '
    '';
  };
  environment.shells = with pkgs; [ zsh bashInteractive ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histFile = "~/.config/zshhistory";
    histSize = 50000;
    interactiveShellInit = ''source ~/.config/zsh/zshrc'';
    promptInit = "";
    enableLsColors = false;
    vteIntegration = true;
    loginShellInit = with builtins; let
      cases = map
        (
          s: ''
            /dev/${elemAt s 0})
              echo "~/.config/xorg/init.sh; ${elemAt s 1}" > ~/.xinitrc;
              sleep 0.2;
              startx;
            ;;
          ''
        )
        sessions;
    in
    ''
      case "$(tty)" in
        ${toString cases}
      esac;
    '';
  };

  services = {
    getty = {
      autologinUser = "imsohexy";
      helpLine = "";
      greetingLine = import ./welcome-text.nix;
    };
  };
}
