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
  #security.sudo.configFile = ''
  # %wheel ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown
  #'';

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
