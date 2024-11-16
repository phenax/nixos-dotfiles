{ ... }:
{
  # imports = [ ./kmonad.nix ];

  services.kmonad = {
    enable = true;
    keyboards = {
      k2 = {
        name = "k2";
        device = "/dev/input/by-id/usb-Keychron_Keychron_K2-event-kbd";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = false;
          compose = { key = null; };
        };
        config = builtins.readFile ./kmonad.k2.kbd;
      };
    };
  };
}
