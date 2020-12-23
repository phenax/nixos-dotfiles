{ pkgs, ... }:
let
  sessions = [
    ["tty1" windowManagers.dwm ]
    #["tty2" windowManagers.bspwm ]
  ];
  windowManagers = {
    dwm = looped "dwm";
    bspwm = exec "bspwm";
  };
  exec = s: "exec ${s}";
  looped = s: ''
    while true; do
      ssh-agent ${s} || break;
    done
  '';
in {
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
    ];
    shell = pkgs.zsh;
  };
  #security.sudo.configFile = ''
  # %wheel ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown
  #'';

  # Global
  environment.variables = let
    apps = (import ./packages/sensible-apps/sensible-apps.nix).apps;
  in {
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
    interactiveShellInit = ''source ~/nixos/external/zsh/zshrc'';
    promptInit = "";
    loginShellInit = with builtins; let
      cases = map (s: ''
        /dev/${elemAt s 0})
          echo "~/nixos/external/xconfig/init.sh; ${elemAt s 1}" > ~/.xinitrc;
          sleep 0.2;
          startx;
        ;;
      '') sessions;
    in ''
      case "$(tty)" in
        ${toString cases}
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
}
