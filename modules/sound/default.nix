{ pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    qjackctl
    ardour
    fluidsynth
    a2jmidid
    pavucontrol
    audacity
    easyeffects
  ];
}
