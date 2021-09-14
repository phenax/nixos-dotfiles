{ pkgs, ... }:
let
  sessions = [
    [ "tty1" windowManagers.xmonad ]
    #[ "tty2" windowManagers.bspwm ]
  ];
  windowManagers = {
    dwm = looped "dwm";
    xmonad = exec "xmonad";
    bspwm = "st; ${exec "bspwm"};";
  };
  exec = s: "exec ${s}";
  looped = s: ''
    while true; do
      ssh-agent ${s} || break;
    done
  '';
in
{

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
    ];
    shell = pkgs.zsh;
  };
  #security.sudo.configFile = ''
  # %wheel ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown
  #'';

  # Global
  environment.variables = let
    apps = (import ./packages/sensible-apps/sensible-apps.nix).apps;
  in
    {
      EDITOR = apps.EDITOR;
      VISUAL = apps.EDITOR;
      TERMINAL = apps.TERMINAL;
      BROWSER = apps.BROWSER;
      PRIVATE_BROWSER = apps.PRIVATE_BROWSER;
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
      cases = map (
        s: ''
          /dev/${elemAt s 0})
            echo "~/.config/xorg/init.sh; ${elemAt s 1}" > ~/.xinitrc;
            sleep 0.2;
            startx;
          ;;
        ''
      ) sessions;
    in
      ''
        case "$(tty)" in
          ${toString cases}
          *) echo "Only tty for you, $(tty)" ;;
        esac;
      '';
  };
  services = {
    getty = {
      autologinUser = "imsohexy";
      helpLine = "";
      greetingLine = import ./modules/welcome-text.nix;
    };
  };
}
