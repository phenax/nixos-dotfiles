# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  apps = (import ./packages/sensible-apps/sensible-apps.nix).apps;
  windowManagers = {
    dwm = ''
      while true; do
        (ssh-agent dwm &>> /tmp/dwm.log) || break;
      done
    '';
  };
in {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
  };

  # Network
  networking.hostName = "dickhead";
  networking.networkmanager.enable = true;

  # I18n and keyboard layout
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";

  # Global
  environment.variables = {
    EDITOR = apps.EDITOR;
    VISUAL = apps.EDITOR;
    TERMINAL = apps.TERMINAL;
    BROWSER = apps.BROWSER;
    PRIVATE_BROWSER = apps.PRIVATE_BROWSER;
  };
  environment.shells = [ pkgs.zsh pkgs.bashInteractive ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histFile = "~/.config/zshhistory";
    histSize = 50000;
    interactiveShellInit = ''source ~/nixos/external/zsh/zshrc'';
    promptInit = "";
    loginShellInit = ''
      setup_dwm() {
        echo "~/nixos/external/xconfig/init.sh; ${windowManagers.dwm}" > ~/.xinitrc;
        sleep 0.2;
      }

      case "$(tty)" in
        /dev/tty1) setup_dwm && startx ;;
        *) echo "Only tty for you, $(tty)" ;;
      esac;
    '';
  };
  services = {
    mingetty = {
      autologinUser = "imsohexy";
      helpLine = "";
      greetingLine = let
        c1 = "\\e{lightblue}";
        c2 = "\\e{lightcyan}";
        res = "\\e{reset}";
      in ''

${c1}          ▗▄▄▄       ${c2}▗▄▄▄▄    ▄▄▄▖${res}
${c1}          ▜███▙       ${c2}▜███▙  ▟███▛${res}                        ${c1}TTY:${res}       \e{bold}\l${res}
${c1}           ▜███▙       ${c2}▜███▙▟███▛${res}                         ${c2}Time:${res}      \e{halfbright}\d \t${res}
${c1}            ▜███▙       ${c2}▜██████▛${res}                          ${c2}Distr${res}      \e{halfbright}\S{PRETTY_NAME} \m${res}
${c1}     ▟█████████████████▙ ${c2}▜████▛     ${c1}▟▙${res}                    ${c2}Kernal:${res}    \e{halfbright}\s \r${res}
${c1}    ▟███████████████████▙ ${c2}▜███▙    ${c1}▟██▙${res}                   ${c2}WM:${res}        \e{halfbright}dwm${res}
${c1}           ▄▄▄▄▖           ▜███▙  ${c1}▟███▛${res}
${c1}          ▟███▛             ▜██▛ ${c1}▟███▛${res}
${c1}         ▟███▛               ▜▛ ${c1}▟███▛${res}
${c1}▟███████████▛                  ${c1}▟██████████▙${res}
${c1}▜██████████▛                  ${c1}▟███████████▛${res}
${c1}      ▟███▛ ${c1}▟▙               ▟███▛${res}
${c1}     ▟███▛ ${c1}▟██▙             ▟███▛${res}
${c1}    ▟███▛  ${c1}▜███▙           ▝▀▀▀▀${res}
${c1}    ▜██▛    ${c1}▜███▙ ${c2}▜██████████████████▛${res}
${c1}     ▜▛     ${c1}▟████▙ ${c2}▜████████████████▛${res}
${c1}           ▟██████▙       ${c2}▜███▙${res}
${c1}          ▟███▛▜███▙       ${c2}▜███▙${res}
${c1}         ▟███▛  ▜███▙       ${c2}▜███▙${res}
${c1}         ▝▀▀▀    ▀▀▀▀▘       ${c2}▀▀▀▘${res}



\e{bold}What's the password, dipshit?\e{reset}'';
    };
  };

  # X11 config
  services.xserver = {
    enable = true;
    autorun = false;
    displayManager.startx.enable = true;
    libinput = {
      enable = true;
      tapping = true;
      naturalScrolling = false;
    };
  };
  fonts.fonts = with pkgs; [
    # jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    cozette
    noto-fonts-emoji
  ];
  services.picom = {
    enable = true;
    inactiveOpacity = 0.8;
    backend = "glx";
    settings = {
      "inactive-dim" = 0.3;
      "focus-exclude" = [ "class_g = 'dwm'" "class_g = 'dmenu'"];
    };
    opacityRules = [
      "98:class_g = 'St' && focused"
      "85:class_g = 'St' && !focused"
      "90:class_g = 'qutebrowser' && !focused"
      "100:class_g = 'qutebrowser' && focused"
    ];
    menuOpacity = 0.9;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;

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
    ];
    shell = pkgs.zsh;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
